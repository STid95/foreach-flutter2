import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle),
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
