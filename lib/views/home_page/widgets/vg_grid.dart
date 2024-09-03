import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants/mocking/games.dart';
import 'package:untitled2/constants/utils/say_hello.dart';

class VGGrid extends StatelessWidget {
  const VGGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      childAspectRatio: 0.8,
      shrinkWrap: true,
      crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
      children: games
          .map(
            (game) => GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    game.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: const ClipOval(
                    child: Image(
                      image: AssetImage('assets/ff7.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: const [
                    VGButton(title: 'Annuler'),
                    VGButton(title: 'Confirmer'),
                  ],
                ),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Card(
                  shape: Border.all(color: Theme.of(context).primaryColorDark),
                  child: Column(
                    children: [
                      Text(
                        game.name,
                        style: const TextStyle(fontSize: 18.0, color: Colors.blue),
                      ),
                      Wrap(
                        children: [
                          for (var i = 0; i < game.grade; i++) const Icon(Icons.star),
                        ],
                      ),
                      Text(game.types.map((e) => e.name).join(', ')),
                      const SizedBox(
                        width: 150,
                        height: 150,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage('assets/ff7.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class VGButton extends StatelessWidget {
  final String title;
  const VGButton({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(backgroundColor: Theme.of(context).secondaryHeaderColor),
      onPressed: sayHello,
      child: Text(title),
    );
  }
}
