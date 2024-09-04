import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameTypeChip extends StatefulWidget {
  final String label;
  final Function(bool) onSelected;

  const GameTypeChip({required this.label, required this.onSelected, super.key});

  @override
  State<GameTypeChip> createState() => _GameTypeChipState();
}

class _GameTypeChipState extends State<GameTypeChip> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
        selectedColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
        label: Text(widget.label),
        selected: isSelected,
        onSelected: (selected) {
          setState(
            () {
              isSelected = selected;
            },
          );
          widget.onSelected(isSelected);
        });
  }
}
