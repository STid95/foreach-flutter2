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
  bool isFamilyFriendly = true;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return VGScaffold(
        title: widget.title,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(children: [
                        const Text('Nom du jeu :'),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).pop();
                              }
                              ;
                            },
                            controller: gameNameController,
                            validator: (value) {
                              if (value == null || value.length < 2) {
                                return "Vous devez entrer un nom";
                              } else
                                return null;
                            },
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              DropdownButton(
                value: dropdownValue,
                items: GameType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
              ),
              Switch(
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
                  value: isFamilyFriendly,
                  onChanged: (value) => setState(() {
                        isFamilyFriendly = value;
                      })),
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
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(gameNameController.value.text)),
                    );
                  }
                },
                child: Text('Récupérer'),
              )
            ],
          ),
        ));
  }
}
