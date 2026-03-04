/// Demonstrates the **Flyweight** pattern.
///
/// Reduces memory consumption by sharing common data among
/// similar objects.
library;

// DART EXAMPLE

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
  // --- 🦋 استخدام وزن الذبابة
  print('Using Flyweight ---');
  final factory = StyleFactory();

  // طلب تنسيق (Arial, 12)...
  print('Requesting style...');
  final s1 = factory.getStyle('Arial', 12);

  // طلب نفس التنسيق مرة أخرى...
  print('Requesting same style again...');
  final s2 = factory.getStyle('Arial', 12);

  // \nهل هما نفس الكائن في الذاكرة؟
  print('Are they the same object in memory?');
  print(
    identical(s1, s2),
  ); // true — نفس الكائن في الذاكرة | same object in memory
}
