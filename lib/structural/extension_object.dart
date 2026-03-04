/// Demonstrates the **Extension Object** pattern.
///
/// Adds new functionality to existing types without modifying them.
/// Dart's `extension` methods provide first-class support for this.
library;

// DART EXAMPLE

// إضافة قدرات لـ String
// Adding capabilities to String
extension StringFormatting on String {
  String get titleCase => split(' ')
      .map(
        (w) => w.isEmpty
            ? w
            : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
      )
      .join(' ');

  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}…';

  bool get isEmail => RegExp(r'^[\w\-.]+@[\w\-.]+\.\w+$').hasMatch(this);
}

// إضافة إحصائيات لـ List<num>
// Adding statistics to List<num>
extension NumListStats on List<num> {
  num get sum => fold<num>(0, (a, b) => a + b);
  double get average => isEmpty ? 0 : sum / length;
}

void main() {
  print('--- 🧩 كائن الامتداد (Extensions) ---');
  // 1. امتداد على النصوص
  print('String Extension:');
  print(
    'النص الأصلي: "hello world" -> بعد التكبير: "${'hello world'.titleCase}"',
  );
  print(
    'النص الأصلي: "Long text here" -> القص (8): "${'Long text here'.truncate(8)}"',
  );
  print('هل "user@mail.com" بريد إلكتروني؟ ${'user@mail.com'.isEmail}');

  // \n2. امتداد على القوائم
  print('List Extension:');
  final List<num> scores = [85, 92, 78, 95, 88];
  // الدرجات
  print('Scores: $scores');
  // المجموع
  print('Sum: ${scores.sum}'); // Sum: 438
  // المتوسط
  print('Average: ${scores.average}'); // Average: 87.6
}
