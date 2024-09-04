import 'package:flutter/material.dart';
import 'package:untitled2/constants/widgets/vg_add_template.dart';
import 'package:untitled2/constants/widgets/vg_scaffold.dart';
import 'package:untitled2/views/home_page/widgets/vg_grid.dart';
import 'package:untitled2/views/home_page/widgets/vg_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return VGScaffold(
      title: 'Home Page',
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const VGGrid(),
              IconButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: SizedBox(
                                  height: MediaQuery.of(context).size.height / 2.5,
                                  child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: AddGame(
                                        onVideoGameCreated: (VideoGame) {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Le jeu ${VideoGame.name} a bien été créé !'),
                                            ),
                                          );
                                        },
                                      ))),
                            ));
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                  )),
              const VGList(),
              /*Container(
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
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
