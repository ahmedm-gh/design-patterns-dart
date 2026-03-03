/// Demonstrates the **Prototype** pattern.
///
/// Creates new objects by cloning existing ones instead of building
/// from scratch.
library;

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
  print('--- ⚙️ إنشاء الإعدادات الافتراضية | Creating Default Config ---');
  final defaultConfig = GameConfig(
    difficulty: 'Normal',
    maxPlayers: 4,
    enabledModes: ['Survival', 'Creative'],
  );
  print('الافتراضي | Default: ${defaultConfig.enabledModes}');

  print('\n--- 🔄 استنساخ وتعديل | Cloning and Modifying ---');
  final customConfig = defaultConfig.clone()
    ..difficulty = 'Hard'
    ..enabledModes.add('Adventure');

  print(
    'الافتراضي (لم يتأثر) | Default (unaffected): ${defaultConfig.enabledModes}',
  );
  print(
    'المُخصَّص (تم تغييره) | Custom (changed): ${customConfig.enabledModes}',
  );
}
