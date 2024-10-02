import 'package:cloud_firestore/cloud_firestore.dart';

import 'game_type.dart';

class VideoGame {
  String? id;
  String name;
  String? description;
  num grade;
  List<GameType> types;
  String? imageUrl;

  VideoGame({
    this.id,
    required this.name,
    this.description,
    required this.grade,
    this.types = const [],
    this.imageUrl,
  });

  void listTypes() {
    for (GameType type in types) {
      if (type.isFamilyFriendly) {
        print("It's Family Friendly");
      }
    }
  }

  factory VideoGame.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    return VideoGame(
      id: snapshot.id,
      name: snapshot['name'],
      grade: snapshot['grade'],
      description: snapshot['description'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'description': this.description ?? '',
      'grade': this.grade,
      'name': this.name,
      'types': this.types.map((type) => type.name).toList() ?? [],
      'image_url': this.imageUrl,
    };
  }
}
