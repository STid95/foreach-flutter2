import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled2/models/video_game.dart';

//Je créé ici le provider que je vais écouter côté UI, et qui va me retourner une list de VideoGame au final
final fireStoreProvider = StateNotifierProvider<FirestoreNotifier, FirebaseFirestore>((ref) => FirestoreNotifier());

//Je créé une classe qui va maintenir le state et appeler les fonctions définies lorsque je fais ref.watch(videoGameListProvider.notifier)
class FirestoreNotifier extends StateNotifier<FirebaseFirestore> {
  FirestoreNotifier() : super(FirebaseFirestore.instance); //La liste est au début vide

  Future<void> addInFirestore(VideoGame game) async {
    state.collection('games').add(game.toDocument());
  }

  Future<void> remove(String docId) async {
    await state.collection('games').doc(docId).delete();
  }

  Future<void> editName(String docId, String newName) async {
    await state.collection('games').doc(docId).update({'alias': newName});
  }

  Future<void> createNewCollection(String collectionId, VideoGame game) async {
    await state.collection(collectionId).add(game.toDocument());
  }
}
