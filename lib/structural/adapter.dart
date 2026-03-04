/// Demonstrates the **Adapter** pattern.
///
/// Converts one class's interface into another interface expected
/// by the client. Acts as a compatibility bridge.
library;

// DART EXAMPLE

// --- الواجهة المتوقعة ---
// --- Target Interface ---
abstract class JsonLogger {
  void logJson(Map<String, dynamic> data);
}

// --- صنف قديم غير متوافق ---
// --- Incompatible Legacy Class ---
class LegacyFileLogger {
  void writeToFile(String text) => print('LOG FILE: $text');
}

// --- المُحوِّل ---
// --- Adapter ---
class FileLoggerAdapter implements JsonLogger {
  final LegacyFileLogger _legacyLogger;
  FileLoggerAdapter(this._legacyLogger);

  @override
  void logJson(Map<String, dynamic> data) {
    final text = data.entries.map((e) => '${e.key}=${e.value}').join(', ');
    _legacyLogger.writeToFile(text);
  }
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  // --- 🔌 استخدام المُحوِّل
  print('Using Adapter ---');
  final JsonLogger logger = FileLoggerAdapter(LegacyFileLogger());
  // إرسال بيانات JSON...
  print('Sending JSON data...');
  logger.logJson({'event': 'login', 'user': 'ahmad'});
}
