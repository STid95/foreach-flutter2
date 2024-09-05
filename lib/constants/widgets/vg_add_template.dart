import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/models/game_type.dart';
import 'package:untitled2/models/video_game.dart';

class AddGame extends HookConsumerWidget {
  //final Function(VideoGame)? onVideoGameCreated;
  //AddGame(this.onVideoGameCreated, {super.key});
  final gameNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPerfect = useState(false);

    final dropdownValue = useState(GameType.RPG);

    VideoGame createNewVideoGame() {
      return VideoGame(
          name: gameNameController.value.text, grade: isPerfect.value ? 5.0 : 3.0, types: [dropdownValue.value]);
    }

    return Column(children: [
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  ),
                  border: const UnderlineInputBorder(),
                  iconColor: Theme.of(context).primaryColor,
                  icon: const Icon(Icons.games_rounded),
                  labelText: 'Nom du jeu',
                  errorStyle: TextStyle(color: Colors.red)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                if (_formKey.currentState!.validate()) {
                  //Navigator.of(context).pop();
                }
              },
              controller: gameNameController,
              validator: (value) {
                if (value == null || value.length < 2) {
                  return "Vous devez entrer un nom";
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
      ),
      Flex(
        direction: Axis.horizontal,
        children: [
          const Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text('Style de jeu :'),
          ),
          const Spacer(),
          Flexible(
            fit: FlexFit.loose,
            flex: 6,
            child: DropdownButton<GameType>(
                value: dropdownValue.value,
                items: GameType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                onChanged: (value) => dropdownValue.value = value ?? dropdownValue.value),
          ),
        ],
      ),
      Flex(
        direction: Axis.horizontal,
        children: [
          const Flexible(flex: 2, fit: FlexFit.tight, child: Text('Parfait ?')),
          const Spacer(),
          Flexible(
              fit: FlexFit.loose,
              flex: 6,
              child: Switch(
                  trackOutlineColor: WidgetStateProperty.resolveWith(
                    (final Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return null;
                      }
                      return Colors.black;
                    },
                  ),
                  inactiveTrackColor: Colors.white,
                  inactiveThumbColor: Theme.of(context).primaryColor,
                  activeColor: Colors.white,
                  value: isPerfect.value,
                  onChanged: (value) => isPerfect.value = value)),

          /* ]),
                Checkbox(
                    value: isFamilyFriendly,
                    onChanged: (value) => setState(() {
                          isFamilyFriendly = value ?? false;
                        })),
                Radio(
                  value: true,
                  onChanged: (value) => setState(() {
                    isFamilyFriendly = value ?? false;
                  }),
                  groupValue: isFamilyFriendly,
                ),*/
        ],
      ),
      TextButton(
        onPressed: () {
          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
            //widget.onVideoGameCreated!(createNewVideoGame());
          }
        },
        child: Text('Ajouter'),
      )
    ]);
  }
}
