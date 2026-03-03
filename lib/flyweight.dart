class CharacterStyle {
  final String font;
  final int size;
  CharacterStyle(this.font, this.size);
}

class StyleFactory {
  final Map<String, CharacterStyle> _cache = {};

  CharacterStyle getStyle(String font, int size) {
    final key = '$font-$size';
    return _cache.putIfAbsent(key, () => CharacterStyle(font, size));
  }
}


void main() {
  // --- Usage ---
  final factory = StyleFactory();
  final s1 = factory.getStyle('Arial', 12);
  final s2 = factory.getStyle('Arial', 12);
  print(identical(s1, s2)); // true — same object in memory
}
