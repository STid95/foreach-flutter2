import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/constants/widgets/vg_dialog.dart';
import 'package:untitled2/logics/firebase_provider.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';

class LoginDialog extends HookConsumerWidget {
  final BuildContext context;
  const LoginDialog({
    required this.context,
    super.key,
  });

  @override
  Widget build(context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final isRegister = useState(false);
    final errorMessage = useState<String?>(null);
    final gameList = ref.watch(videoGameListProvider).map((videoGame) => videoGame.name).toSet().toList();
    final favoriteVideoGame = useState<String?>(gameList.first);

    return VGDialog(
      content: Column(
        children: [
          Row(children: [
            Text('Inscription'),
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
                value: isRegister.value,
                onChanged: (value) {
                  isRegister.value = value;
                  errorMessage.value = null;
                })
          ]),
          Text(isRegister.value ? 'Inscription' : 'Me connecter'),
          TextFormField(
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                ),
                border: const UnderlineInputBorder(),
                labelText: 'Email',
                errorStyle: TextStyle(color: Colors.red)),
            onChanged: (value) {},
            controller: emailController,
            validator: (value) {
              if (value == null || value.length < 2 || !value.contains(('@'))) {
                return "Vous devez entrer un email valide";
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                ),
                border: const UnderlineInputBorder(),
                labelText: 'Mot de passe',
                errorStyle: TextStyle(color: Colors.red)),
            onChanged: (value) {},
            controller: passwordController,
          ),
          DropdownButton(
              value: gameList.first,
              items: gameList
                  .toSet()
                  .map(
                    (game) => DropdownMenuItem(
                      value: game,
                      child: Text(game),
                    ),
                  )
                  .toList(),
              onChanged: (value) => favoriteVideoGame.value = value),
          Text(errorMessage.value ?? ''),
          TextButton(
              onPressed: () async {
                if (isRegister.value) {
                  errorMessage.value = await ref.read(firebaseAuthProvider.notifier).createUserInFirebase(
                      emailController.value.text, passwordController.value.text, favoriteVideoGame.value ?? '');
                } else {
                  errorMessage.value = await ref
                      .read(firebaseAuthProvider.notifier)
                      .logIn(emailController.value.text, passwordController.value.text);
                }
                if (ref.watch(firebaseUser) != null) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              child: Text('Go'))
        ],
      ),
    );
  }
}
