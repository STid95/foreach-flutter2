import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants/mocking/games.dart';

class VGList extends StatelessWidget {
  const VGList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      shrinkWrap: true,
      children: games
          .map(
            (game) => ListTile(
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
            ),
          )
          .toList(),
    );
  }
}
