// --- Target Interface ---
abstract class JsonLogger {
  void logJson(Map<String, dynamic> data);
}

// --- Incompatible Legacy Class (Adaptee) ---
class LegacyFileLogger {
  void writeToFile(String text) => print('LOG FILE: $text');
}

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
  // --- Usage ---
  final JsonLogger logger = FileLoggerAdapter(LegacyFileLogger());
  logger.logJson({'event': 'login', 'user': 'ahmad'}); // LOG FILE: event=login, user=ahmad
}
