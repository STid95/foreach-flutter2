import '../../models/game_type.dart';
import '../../models/video_game.dart';

List<VideoGame> games = [
  VideoGame(
      name: "Final Fantasy",
      grade: 3.0,
      types: [GameType("RPG", "Jeu de rôle", true), GameType("J-RPG", "Jeu de rôle japonais", true)]),
  VideoGame(name: "Halo", grade: 5.0),
  VideoGame(
      name: "Final Fantasy",
      grade: 3.0,
      types: [GameType("RPG", "Jeu de rôle", true), GameType("J-RPG", "Jeu de rôle japonais", true)]),
  VideoGame(name: "Halo", grade: 5.0),
  VideoGame(
      name: "Final Fantasy",
      grade: 3.0,
      types: [GameType("RPG", "Jeu de rôle", true), GameType("J-RPG", "Jeu de rôle japonais", true)]),
  VideoGame(name: "Halo", grade: 5.0)
];
