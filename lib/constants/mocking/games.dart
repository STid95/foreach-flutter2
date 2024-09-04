import '../../models/game_type.dart';
import '../../models/video_game.dart';

List<VideoGame> games = [
  VideoGame(name: "Final Fantasy", grade: 3.0, types: [GameType.RPG]),
  VideoGame(name: "Halo", grade: 5.0, types: [GameType.FPS]),
  VideoGame(name: "Final Fantasy", grade: 3.0, types: [GameType.RPG]),
  VideoGame(name: "Halo", grade: 5.0, types: [GameType.FPS]),
  VideoGame(name: "Final Fantasy", grade: 3.0, types: [GameType.RPG]),
  VideoGame(name: "The Sims", grade: 5.0, types: [GameType.RPG, GameType.Simulation])
];
