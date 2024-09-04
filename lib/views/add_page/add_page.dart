import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants/widgets/vg_scaffold.dart';
import 'package:untitled2/models/game_type.dart';

class AddPage extends StatefulWidget {
  final String title;
  const AddPage({required this.title, super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final gameNameController = TextEditingController();
  GameType? dropdownValue = GameType.RPG;
  bool isPerfect = false;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return VGScaffold(
        title: widget.title,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        ),
                        border: const UnderlineInputBorder(),
                        iconColor: Theme.of(context).primaryColor,
                        icon: Icon(Icons.games_rounded),
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
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      const Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: Text('Nom du jeu :'),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 6,
                        fit: FlexFit.tight,
                        child: TextFormField(
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
                      )
                    ],
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
                  child: DropdownButton(
                    value: dropdownValue,
                    items: GameType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                  ),
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
                      value: isPerfect,
                      onChanged: (value) => setState(() {
                            isPerfect = value;
                          })),
                ),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(gameNameController.value.text)),
                  );
                }
              },
              child: Text('Ajouter'),
            )
          ]),
        )));
  }
}
