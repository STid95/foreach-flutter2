import 'package:flutter/cupertino.dart';
import 'package:untitled2/constants/mocking/games.dart';
import 'package:untitled2/constants/widgets/type_chip.dart';
import 'package:untitled2/models/game_type.dart';
import 'package:untitled2/models/video_game.dart';

class FilterWrap extends StatefulWidget {
  final Function(bool, GameType) onChipSelected;

  const FilterWrap({super.key, required this.onChipSelected});

  @override
  State<FilterWrap> createState() => _FilterWrapState();
}

class _FilterWrapState extends State<FilterWrap> {
  List<VideoGame> filteredGames = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10.0,
        children: GameType.values.map(
          (type) {
            return GameTypeChip(label: type.name, onSelected: (isSelected) => widget.onChipSelected(isSelected, type));
          },
        ).toList());
  }
}
