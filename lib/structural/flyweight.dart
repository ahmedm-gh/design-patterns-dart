/// Demonstrates the **Flyweight** pattern.
///
/// Reduces memory consumption by sharing common data among
/// similar objects.
library;

/// An immutable character style (intrinsic state).
final class CharacterStyle {
  /// The font family name.
  final String font;

  /// The font size in points.
  final int size;

  /// Creates a character style with the given [font] and [size].
  const CharacterStyle(this.font, this.size);
}

/// A factory that caches and reuses [CharacterStyle] instances.
class StyleFactory {
  final Map<String, CharacterStyle> _cache = {};

  /// Returns a cached [CharacterStyle] for the given [font] and [size],
  /// creating one if it doesn't already exist.
  CharacterStyle getStyle(String font, int size) {
    final key = '$font-$size';
    return _cache.putIfAbsent(key, () => CharacterStyle(font, size));
  }
}

void main() {
  final factory = StyleFactory();
  final s1 = factory.getStyle('Arial', 12);
  final s2 = factory.getStyle('Arial', 12);
  print(identical(s1, s2)); // true — same object in memory
}
