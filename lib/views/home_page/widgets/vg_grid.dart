import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants/mocking/games.dart';
import 'package:untitled2/constants/utils/say_hello.dart';
import 'package:untitled2/models/game_type.dart';
import 'package:untitled2/models/video_game.dart';
import 'package:untitled2/views/home_page/widgets/filter_wrap.dart';

import 'game_card.dart';

class VGGrid extends StatefulWidget {
  const VGGrid({super.key});

  @override
  State<VGGrid> createState() => _VGGridState();
}

class _VGGridState extends State<VGGrid> {
  List<VideoGame> filteredGames = [];
  bool choiceChipSelected = false;

  void filterList(bool isSelected, GameType type) {
    if (!isSelected && filteredGames.any((game) => game.types.contains(type))) {
      filteredGames.removeWhere((game) => game.types.contains(type));
    } else if (isSelected) {
      filteredGames.addAll(games.where((game) => game.types.contains(type)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
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
        FilterWrap(
          onChipSelected: (isSelected, type) => setState(
            () {
              filterList(isSelected, type);
            },
          ),
        ),
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
