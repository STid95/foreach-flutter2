import 'package:cloud_firestore/cloud_firestore.dart';

class VGUser {
  String id;
  String email;
  String favoriteGame;

  VGUser ({required this.id, required this.email, required this.favoriteGame});

  factory VGUser.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    return VGUser(
      id: snapshot.id,
      email: snapshot['email'],
      favoriteGame: snapshot['favoriteGame'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'email': this.email,
      'favorite_game': this.favoriteGame,
    };
  }
}