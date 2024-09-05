import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';

import 'game_card.dart';

class GamesGridView extends HookConsumerWidget {
  const GamesGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredGames = ref.watch(
        filteredVideoGameListProvider); //J'écoute mon provider, à chaque changement de state ma variable games va changer aussi
    final games = ref.watch(videoGameListProvider);
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      childAspectRatio: 0.8,
      shrinkWrap: true,
      crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
      children: filteredGames.isNotEmpty
          ? filteredGames
              .map(
                (game) => GameCard(game: game),
              )
              .toList()
          : games
              .map(
                (game) => GameCard(game: game),
              )
              .toList(),
    );
  }
}
