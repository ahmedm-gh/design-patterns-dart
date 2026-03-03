/// Demonstrates the **Multiton** pattern.
///
/// Like Singleton, but manages a registry of named instances.
/// Each key maps to exactly one instance.
library;

/// A logger that maintains one instance per named channel.
final class Logger {
  static final Map<String, Logger> _instances = {};

  /// The channel name for this logger.
  final String channel;

  Logger._internal(this.channel);

  /// Returns the [Logger] for the given [channel], creating it
  /// on first access.
  factory Logger(String channel) {
    return _instances.putIfAbsent(channel, () {
      print('🆕 Creating logger for "$channel"');
      return Logger._internal(channel);
    });
  }

  /// Logs a [message] to this channel.
  void log(String message) => print('[$channel] $message');
}

void main() {
  final authLogger1 = Logger('auth');
  final authLogger2 = Logger('auth');
  final dbLogger = Logger('database');

  print(identical(authLogger1, authLogger2)); // true — same instance
  print(identical(authLogger1, dbLogger)); // false — different channel

  authLogger1.log('User logged in');
  dbLogger.log('Query executed');
  // [auth] User logged in
  // [database] Query executed
}
