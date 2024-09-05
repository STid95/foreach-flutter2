import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants/widgets/vg_add_template.dart';

class AddGameBtn extends StatelessWidget {
  const AddGameBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(context: context, builder: (context) => VGDialog());
        },
        icon: const Icon(
          Icons.add,
          size: 40,
        ));
  }
}

class VGDialog extends StatelessWidget {
  const VGDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: AddGame(
                  /*(VideoGame) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Le jeu ${VideoGame.name} a bien été créé !'),
                            ),
                          );
                        },*/
                  ))),
    );
  }
}
