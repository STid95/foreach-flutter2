import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';

class GamesButton extends ConsumerWidget {
  const GamesButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Badge(
        label: Text(ref.watch(videoGameListProvider).length.toString()),
        child: Icon(Icons.games),
      ),
      //Je maintiens à jour mon nombre de jeux vidéos : le label changera à chaque ajout, et ceci pour toute l'appli
    );
  }
}
