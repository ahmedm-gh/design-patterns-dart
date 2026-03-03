/// Demonstrates the **Prototype** pattern.
///
/// Creates new objects by cloning existing ones instead of building
/// from scratch.
library;

/// A game configuration that supports deep cloning.
class GameConfig {
  /// The difficulty level.
  String difficulty;

  /// The maximum number of players.
  int maxPlayers;

  /// The list of enabled game modes.
  List<String> enabledModes;

  /// Creates a game configuration with the given settings.
  GameConfig({
    required this.difficulty,
    required this.maxPlayers,
    required this.enabledModes,
  });

  /// Returns a deep copy of this configuration.
  GameConfig clone() {
    return GameConfig(
      difficulty: difficulty,
      maxPlayers: maxPlayers,
      enabledModes: List<String>.of(enabledModes),
    );
  }
}

void main() {
  final defaultConfig = GameConfig(
    difficulty: 'Normal',
    maxPlayers: 4,
    enabledModes: ['Survival', 'Creative'],
  );

  final customConfig = defaultConfig.clone()
    ..difficulty = 'Hard'
    ..enabledModes.add('Adventure');

  print(defaultConfig.enabledModes); // [Survival, Creative] — unaffected
  print(customConfig.enabledModes); // [Survival, Creative, Adventure]
}
