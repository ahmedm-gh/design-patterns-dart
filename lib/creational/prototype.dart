/// Demonstrates the **Prototype** pattern.
///
/// Creates new objects by cloning existing ones instead of building
/// from scratch.
library;

// DART EXAMPLE

class GameConfig {
  String difficulty;
  int maxPlayers;
  List<String> enabledModes;

  GameConfig({
    required this.difficulty,
    required this.maxPlayers,
    required this.enabledModes,
  });

  // نسخ عميق — نسخ القائمة لا مشاركتها
  // Deep Copy — copy the list, don't share it
  GameConfig clone() {
    return GameConfig(
      difficulty: difficulty,
      maxPlayers: maxPlayers,
      enabledModes: List.from(enabledModes),
    );
  }
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  // --- ⚙️ إنشاء الإعدادات الافتراضية
  print('Creating Default Config ---');
  final defaultConfig = GameConfig(
    difficulty: 'Normal',
    maxPlayers: 4,
    enabledModes: ['Survival', 'Creative'],
  );
  // الافتراضي
  print('Default: ${defaultConfig.enabledModes}');

  // --- 🔄 استنساخ وتعديل
  print('Cloning and Modifying ---');
  final customConfig = defaultConfig.clone()
    ..difficulty = 'Hard'
    ..enabledModes.add('Adventure');

  // الافتراضي (لم يتأثر)
  print('Default (unaffected): ${defaultConfig.enabledModes}');
  // المُخصَّص (تم تغييره)
  print('Custom (changed): ${customConfig.enabledModes}');
}
