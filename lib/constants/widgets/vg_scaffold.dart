import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/logics/firebase_provider.dart';

import 'games_button.dart';
import 'login_dialog.dart';

class VGScaffold extends StatelessWidget {
  const VGScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LoginButton(),
        actions: const [
          GamesButton(),
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

class LoginButton extends ConsumerWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> signOut() async {
      try {
        ref.watch(firebaseAuthProvider.notifier).logout();
      } on FirebaseAuthException catch (e) {
        print(e);
      } catch (e) {
        print(e);
      }
    }

    return IconButton(
      onPressed: () => ref.watch(firebaseUser) != null
          ? signOut()
          : showDialog(
              context: context,
              builder: (context) => LoginDialog(
                context: context,
              ),
            ),
      icon: Icon(
        ref.watch(firebaseUser) != null ? Icons.logout : Icons.login,
      ),
    );
  }
}
