/// Demonstrates the **Template Method** pattern.
///
/// Defines the skeleton of an algorithm and lets subclasses
/// override specific steps.
library;

/// A base class for exporting data in various formats.
abstract class DataExporter {
  /// Exports data by fetching, formatting, and saving it.
  ///
  /// This is the **template method** — the fixed skeleton.
  void export() {
    final data = fetchData();
    final formatted = format(data);
    save(formatted);
  }

  /// Fetches the raw data to export (primitive operation).
  List<String> fetchData();

  /// Formats the [data] into the target format (primitive operation).
  String format(List<String> data);

  /// Saves the formatted [output] (hook — can be overridden).
  void save(String output) => print('💾 Saved: $output');
}

/// Exports data in CSV format.
final class CsvExporter extends DataExporter {
  @override
  List<String> fetchData() => ['name', 'age', 'city'];

  @override
  String format(List<String> data) => data.join(',');
}

/// Exports data in JSON format.
final class JsonExporter extends DataExporter {
  @override
  List<String> fetchData() => ['name', 'age', 'city'];

  @override
  String format(List<String> data) =>
      '{"fields": [${data.map((e) => '"$e"').join(', ')}]}';
}

void main() {
  CsvExporter().export(); // 💾 Saved: name,age,city
  JsonExporter().export(); // 💾 Saved: {"fields": ["name", "age", "city"]}
}
