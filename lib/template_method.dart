abstract class DataExporter {
  // Template Method — the fixed skeleton
  void export() {
    final data = fetchData();
    final formatted = format(data);
    save(formatted);
  }

  List<String> fetchData();          // Primitive operation
  String format(List<String> data);  // Primitive operation
  void save(String output) => print('💾 Saved: $output'); // Hook
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
  // --- Usage ---
  CsvExporter().export();  // 💾 Saved: name,age,city
  JsonExporter().export(); // 💾 Saved: {"fields": ["name", "age", "city"]}
}
