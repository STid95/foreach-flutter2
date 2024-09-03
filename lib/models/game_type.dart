enum GameType {
  RPG("Jeu de rôle", true),
  FPS("First Person Shooter", false),
  Simulation("Simulation", true);

  const GameType(this.name, this.isFamilyFriendly);
  final String name;

  final bool isFamilyFriendly;
}
