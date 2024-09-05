import 'package:cloud_firestore/cloud_firestore.dart';

import 'game_type.dart';

class VideoGame {
  String name;
  String? description;
  num grade;
  List<GameType> types;

  VideoGame({required this.name, this.description, required this.grade, this.types = const []});

  void listTypes() {
    for (GameType type in types) {
      if (type.isFamilyFriendly) {
        print("It's Family Friendly");
      }
    }
  }

  factory VideoGame.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    return VideoGame(
      name: snapshot['name'],
      grade: snapshot['grade'],
      description: snapshot['description'],
    );
  }
}
