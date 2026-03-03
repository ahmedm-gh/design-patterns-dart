/// Demonstrates the **Extension Object** pattern.
///
/// Adds new functionality to existing types without modifying them.
/// Dart's `extension` methods provide first-class support for this.
library;

/// Adds formatting utilities to [String].
extension StringFormatting on String {
  /// Returns this string in title case (first letter of each word capitalized).
  String get titleCase => split(' ')
      .map(
        (w) => w.isEmpty
            ? w
            : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
      )
      .join(' ');

  /// Returns this string truncated to [maxLength] with an ellipsis.
  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}…';

  /// Whether this string is a valid email address.
  bool get isEmail => RegExp(r'^[\w\-.]+@[\w\-.]+\.\w+$').hasMatch(this);
}

/// Adds statistical utilities to `List<num>`.
extension NumListStats on List<num> {
  /// The sum of all elements.
  num get sum => fold<num>(0, (a, b) => a + b);

  /// The arithmetic mean (average).
  double get average => isEmpty ? 0 : sum / length;

  /// The maximum value.
  num get max => reduce((a, b) => a > b ? a : b);

  /// The minimum value.
  num get min => reduce((a, b) => a < b ? a : b);
}

void main() {
  // String extensions
  print('hello world'.titleCase); // Hello World
  print('A very long description'.truncate(10)); // A very lon…
  print('user@example.com'.isEmail); // true
  print('not-an-email'.isEmail); // false

  // List<num> extensions
  final List<num> scores = [85, 92, 78, 95, 88];
  print('Sum: ${scores.sum}'); // Sum: 438
  print('Average: ${scores.average}'); // Average: 87.6
  print('Max: ${scores.max}'); // Max: 95
  print('Min: ${scores.min}'); // Min: 78
}
