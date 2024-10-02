import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled2/logics/firestore_provider.dart';
import 'package:untitled2/models/game_type.dart';
import 'package:untitled2/models/video_game.dart';

class AddGame extends HookConsumerWidget {
  final Function(VideoGame)? onVideoGameCreated;
  AddGame(this.onVideoGameCreated, {super.key});
  final gameNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPerfect = useState(false);

    final dropdownValue = useState(GameType.RPG);

    final imageUrl = useState<String?>(null);

    VideoGame createNewVideoGame() {
      return VideoGame(
          name: gameNameController.value.text,
          grade: isPerfect.value ? 5.0 : 3.0,
          types: [dropdownValue.value],
          imageUrl: imageUrl.value);
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
              onChanged: (value) {},
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
      IconButton(
        icon: Icon(Icons.add_a_photo),
        onPressed: () async {
          final image = await ImagePicker().pickImage(source: ImageSource.gallery);
          print(image?.name);
          if (image != null) {
            File file = File(image.path);

            // Create the file metadata
            final metadata = SettableMetadata(contentType: image.mimeType);

// Create a reference to the Firebase Storage bucket
            final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
            final uploadTask = storageRef.child("images/${image.name}").putFile(file, metadata);

// Listen for state changes, errors, and completion of the upload.
            uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
              switch (taskSnapshot.state) {
                case TaskState.running:
                  final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
                  print("Upload is $progress% complete.");
                  break;
                case TaskState.paused:
                  print("Upload is paused.");
                  break;
                case TaskState.canceled:
                  print("Upload was canceled");
                  break;
                case TaskState.error:
                  // Handle unsuccessful uploads
                  break;
                case TaskState.success:
                  imageUrl.value = await storageRef.child("images/${image.name}").getDownloadURL();
                  break;
              }
            });
          }
        },
      ),
      if (imageUrl.value != null) SizedBox(height: 100, width: 100, child: Image.network(imageUrl.value!)),
      TextButton(
        onPressed: () {
          ref.watch(fireStoreProvider.notifier).addInFirestore(createNewVideoGame());

          onVideoGameCreated!(createNewVideoGame());
        },
        child: Text('Ajouter'),
      )
    ]);
  }
}
