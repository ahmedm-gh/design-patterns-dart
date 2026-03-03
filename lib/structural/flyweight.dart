/// Demonstrates the **Flyweight** pattern.
///
/// Reduces memory consumption by sharing common data among
/// similar objects.
library;

class CharacterStyle {
  final String font;
  final int size;
  CharacterStyle(this.font, this.size);
}

// --- المصنع — يُعيد استخدام النُّسخ المُشتركة ---
// --- Factory — reuses shared instances ---
class StyleFactory {
  final Map<String, CharacterStyle> _cache = {};

  CharacterStyle getStyle(String font, int size) {
    final key = '$font-$size';
    return _cache.putIfAbsent(key, () => CharacterStyle(font, size));
  }
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 🦋 استخدام وزن الذبابة | Using Flyweight ---');
  final factory = StyleFactory();

  print('طلب تنسيق (Arial, 12)... | Requesting style...');
  final s1 = factory.getStyle('Arial', 12);

  print('طلب نفس التنسيق مرة أخرى... | Requesting same style again...');
  final s2 = factory.getStyle('Arial', 12);

  print(
    '\nهل هما نفس الكائن في الذاكرة؟ | Are they the same object in memory?',
  );
  print(
    identical(s1, s2),
  ); // true — نفس الكائن في الذاكرة | same object in memory
}
