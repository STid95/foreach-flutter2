import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';

class VGScaffold extends ConsumerWidget {
  const VGScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              child: Icon(Icons.games),
              label: Text(ref
                  .watch(videoGameListProvider)
                  .length
                  .toString()), //Je maintiens à jour mon nombre de jeux vidéos : le label changera à chaque ajout, et ceci pour toute l'appli
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
      ),
      body: body,
    );
  }
}
