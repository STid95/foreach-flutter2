import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/constants/widgets/vg_add_template.dart';
import 'package:untitled2/constants/widgets/vg_scaffold.dart';
import 'package:untitled2/logics/firebase_provider.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';
import 'package:untitled2/views/home_page/widgets/add_game_btn.dart';
import 'package:untitled2/views/home_page/widgets/vg_grid.dart';
import 'package:untitled2/views/home_page/widgets/vg_list.dart';

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() {
      ref.read(videoGameListProvider.notifier).initialize();
      ref.read(firebaseAuthProvider.notifier).initialize();
    });
    return const VGScaffold(
      title: 'Home Page',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //VGGrid(),
          VGList(),
          AddGameBtn(),

          /*Container(
            //Box qui contient un enfant et permet par exemple de définir des bordures
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.black),
            ),
            child: const Text('Test'),
          ),*/
        ],
      ),
    );
  }
}
