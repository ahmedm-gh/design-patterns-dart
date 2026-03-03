/// Demonstrates the **Adapter** pattern.
///
/// Converts one class's interface into another interface expected
/// by the client. Acts as a compatibility bridge.
library;

/// The target interface the client expects.
abstract interface class JsonLogger {
  /// Logs structured [data] in JSON format.
  void logJson(Map<String, dynamic> data);
}

/// A legacy logger with an incompatible interface (adaptee).
class LegacyFileLogger {
  /// Writes [text] to a log file.
  void writeToFile(String text) => print('LOG FILE: $text');
}

/// Adapts [LegacyFileLogger] to the [JsonLogger] interface.
final class FileLoggerAdapter implements JsonLogger {
  final LegacyFileLogger _legacyLogger;

  /// Creates an adapter wrapping the given [legacyLogger].
  FileLoggerAdapter(LegacyFileLogger legacyLogger)
    : _legacyLogger = legacyLogger;

  @override
  void logJson(Map<String, dynamic> data) {
    final text = data.entries.map((e) => '${e.key}=${e.value}').join(', ');
    _legacyLogger.writeToFile(text);
  }
}

void main() {
  final JsonLogger logger = FileLoggerAdapter(LegacyFileLogger());
  logger.logJson({
    'event': 'login',
    'user': 'ahmad',
  }); // LOG FILE: event=login, user=ahmad
}
