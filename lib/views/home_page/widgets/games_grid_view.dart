import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/logics/firestore_provider.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';
import 'package:untitled2/models/video_game.dart';

import 'game_card.dart';

class GamesGridView extends HookConsumerWidget {
  const GamesGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredGames = ref.watch(
        filteredVideoGameListProvider); //J'écoute mon provider, à chaque changement de state ma variable games va changer aussi
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
            final firebaseGames = snapshot.data!.docs;
            return GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              childAspectRatio: 0.8,
              shrinkWrap: true,
              crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
              /*children: filteredGames.isNotEmpty
                ? filteredGames
                    .map(
                      (game) => GameCard(game: game),
                    )
                    .toList()
                : games
                    .map(
                      (game) => GameCard(game: game),
                    )
                    .toList(),*/
              children: firebaseGames.map((doc) {
                final game = VideoGame.fromQueryDocumentSnapshot(doc);
                return Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => ref.read(fireStoreProvider.notifier).createNewCollection('newGames', game)),
                    Row(
                      children: [
                        Text(game.name),
                        IconButton(
                          icon: Icon(Icons.mode),
                          onPressed: () => ref.read(fireStoreProvider.notifier).editName(game.id ?? '', "Mario"),
                        )
                      ],
                    ),
                    Text(game.description ?? ''),
                    Text('Grade : ${game.grade}'),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => ref.read(fireStoreProvider.notifier).remove(game.id ?? ''))
                  ],
                );
              }).toList(),
            );
          }
        });
  }
}
