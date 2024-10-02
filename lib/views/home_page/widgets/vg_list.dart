import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled2/constants/mocking/games.dart';
import 'package:untitled2/logics/firestore_provider.dart';
import 'package:untitled2/models/video_game.dart';

class VGList extends ConsumerWidget {
  const VGList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fireStore = ref.watch(fireStoreProvider);
    final Stream<QuerySnapshot> gamesStream = fireStore.collection('games').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: gamesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            ref.watch(fireStoreProvider.notifier).updateGameList(snapshot.data!.docs);

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              shrinkWrap: true,
              children: ref.watch(gameListProvider).map(
                (game) {
                  return ListTile(
                    leading: const Icon(Icons.ad_units_rounded),
                    title: Text(
                      game.name,
                      style: const TextStyle(fontSize: 18.0, color: Colors.blue),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            for (var i = 0; i < game.grade; i++) const Icon(Icons.star),
                          ],
                        ),
                        Text(game.types.map((e) => e.name).join(', '))
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          }
        });
  }
}
