import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';
import 'package:untitled2/models/game_type.dart';
import 'package:untitled2/models/video_game.dart';
import 'package:untitled2/views/home_page/widgets/filter_wrap.dart';

import 'game_card.dart';

class VGGrid extends ConsumerStatefulWidget {
  const VGGrid({super.key});

  @override
  ConsumerState<VGGrid> createState() => _VGGridState();
}

class _VGGridState extends ConsumerState<VGGrid> {
  bool choiceChipSelected = false;

  @override
  void initState() {
    super.initState();
    ref.read(videoGameListProvider.notifier).initialize(); //A l'init state, j'initialise ma liste mockée
  }

  @override
  Widget build(BuildContext context) {
    final games = ref.watch(
        videoGameListProvider); //J'écoute mon provider, à chaque changement de state ma variable games va changer aussi
    final filteredGames = ref.watch(filteredVideoGameListProvider);

    return Column(
      children: [
        Wrap(
          children: [
            ChoiceChip(
                selectedColor: Colors.red,
                disabledColor: Colors.blue,
                showCheckmark: false,
                label: Icon(Icons.ac_unit_outlined),
                selected: choiceChipSelected,
                onSelected: (selected) => setState(() {
                      choiceChipSelected = selected;
                    })),
            Chip(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              label: Text('Simple Chip'),
              backgroundColor: Colors.white,
            ),
            ActionChip(
                label: Text('Retirer mes filtres'),
                onPressed: () => setState(() {
                      choiceChipSelected = false;
                    }))
          ],
        ),
        TextButton(
          child: Text('Add Videogame'),
          onPressed: () {
            ref.read(videoGameListProvider.notifier).add(
                  //Cela va ainsi faire automatiquement rebuild mon grid
                  VideoGame(
                    name: "WoW",
                    grade: 5.0,
                    types: [GameType.RPG],
                  ),
                );
          },
        ),
        FilterWrap(
            onChipSelected: (isSelected, type) =>
                ref.read(filteredVideoGameListProvider.notifier).filterList(isSelected, type)),
        GridView.count(
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
        ),
      ],
    );
  }
}
