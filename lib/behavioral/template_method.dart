/// Demonstrates the **Template Method** pattern.
///
/// Defines the skeleton of an algorithm and lets subclasses
/// override specific steps.
library;

abstract class DataExporter {
  // أسلوب القالب — الهيكل الثابت
  // Template Method — the fixed skeleton
  void export() {
    final data = fetchData();
    final formatted = format(data);
    save(formatted);
  }

  List<String> fetchData(); // عملية أوّلية | Primitive operation
  String format(List<String> data); // عملية أوّلية | Primitive operation
  void save(String output) => print('💾 حفظ | Saved: $output'); // خُطّاف | Hook
}

class CsvExporter extends DataExporter {
  @override
  List<String> fetchData() => ['name', 'age', 'city'];

  @override
  String format(List<String> data) => data.join(',');
}

class JsonExporter extends DataExporter {
  @override
  List<String> fetchData() => ['name', 'age', 'city'];

  @override
  String format(List<String> data) =>
      '{"fields": [${data.map((e) => '"$e"').join(', ')}]}';
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print(
    '--- 📄 أسلوب القالب (تصدير كـ CSV) | Template Method (CSV Export) ---',
  );
  CsvExporter().export();

  print(
    '\n--- � أسلوب القالب (تصدير كـ JSON) | Template Method (JSON Export) ---',
  );
  JsonExporter().export();
}
