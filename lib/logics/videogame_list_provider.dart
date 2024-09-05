import 'dart:convert';

import 'package:riverpod/riverpod.dart';
import 'package:untitled2/constants/mocking/games.dart';
import 'package:untitled2/models/game_type.dart';
import 'package:untitled2/models/video_game.dart';

//Je créé ici le provider que je vais écouter côté UI, et qui va me retourner une list de VideoGame au final
final videoGameListProvider = StateNotifierProvider<VGListNotifier, List<VideoGame>>((ref) => VGListNotifier());

//Je créé une classe qui va maintenir le state et appeler les fonctions définies lorsque je fais ref.watch(videoGameListProvider.notifier)
class VGListNotifier extends StateNotifier<List<VideoGame>> {
  VGListNotifier() : super([]); //La liste est au début vide
  Future<void> initialize() async {
    state = List.from(games); //Je récupère la liste mockée
  }

  Future<void> add(VideoGame game) async {
    state.add(game);
    state = List.from(state); //Cela va trigger les widgets qui écoutent le provider
  }

  Future<void> remove(String newTask) async {
    state.remove(newTask);
    state = List.from(state);
  }
}

//Je fais la même chose pour la liste filtrée
final filteredVideoGameListProvider =
    StateNotifierProvider<FilteredVGListNotifier, List<VideoGame>>((ref) => FilteredVGListNotifier(ref));

class FilteredVGListNotifier extends StateNotifier<List<VideoGame>> {
  Ref ref; //J'en ai besoin pour accéder au stade de la liste globale

  FilteredVGListNotifier(this.ref) : super([]);

  filterList(bool isSelected, GameType type) {
    if (!isSelected && state.any((game) => game.types.contains(type))) {
      state.removeWhere((game) => game.types.contains(type));
      state = List.from(state);
    } else if (isSelected) {
      //Je fais ref.watch pour accéder à la liste globale et rebuild ma liste filtrée si ma liste de base change
      state.addAll(ref.watch(videoGameListProvider).where((game) => game.types.contains(type)).toList());
      state = List.from(state);
    }
  }
}
