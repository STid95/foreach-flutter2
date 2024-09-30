import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled2/logics/firebase_provider.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';

class VGScaffold extends ConsumerWidget {
  const VGScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> logIn() async {
      try {
        ref.watch(firebaseAuthProvider.notifier).logIn('ncontant@yahoo.fr', 'Test1234!');
      } on FirebaseAuthException catch (e) {
        ref.watch(firebaseAuthProvider.notifier).signIn('ncontant@yahoo.fr', 'Test1234!');
        print(e);
      } catch (e) {
        print(e);
      }
    }

    Future<void> signOut() async {
      try {
        ref.watch(firebaseAuthProvider.notifier).logout();
      } on FirebaseAuthException catch (e) {
        print(e);
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => ref.watch(firebaseUser) != null ? signOut() : logIn(),
          icon: Icon(
            ref.watch(firebaseUser) != null ? Icons.logout : Icons.login,
          ),
        ),
        actions: [
          ActionButton(
            icon: Icons.games,
            label: ref.watch(videoGameListProvider).length.toString(),
          ),
          ActionButton(
            icon: Icons.add,
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Center(child: body),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  ActionButton({
    required this.icon,
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Badge(
        label: label != null ? Text(label!) : null,
        child: Icon(icon),
      ),
      //Je maintiens à jour mon nombre de jeux vidéos : le label changera à chaque ajout, et ceci pour toute l'appli
    );
  }
}
