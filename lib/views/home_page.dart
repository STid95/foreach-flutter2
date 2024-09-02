import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/video_game.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<VideoGame> games = [VideoGame(name: "Final Fantasy", grade: 3.0), VideoGame(name: "Halo", grade: 5.0)];
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle),
        actions: [Icon(Icons.login)],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: games
                  .map(
                    (game) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        child: Column(
                          children: [
                            Text(game.name),
                            Text(game.grade.toString()),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Container(
              //Box qui contient un enfant et permet par exemple de définir des bordures
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.black),
              ),
              child: const Text('Test'),
            ),
            GestureDetector(
              //Capte un geste user (ex clic) et fait une action
              child: const Icon(Icons.add),
              onTap: () => print('coucou'),
            )
          ],
        ),
      ),
    );
  }
}
