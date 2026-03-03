/// Demonstrates the **Singleton** pattern.
///
/// Ensures a class has only one instance throughout the application's
/// lifetime and provides a global access point to it.
library;

/// A global application configuration (singleton).
final class AppConfig {
  /// Dart guarantees static final fields are initialized once (lazy).
  static final AppConfig _instance = AppConfig._internal();

  /// The application name.
  String appName = 'MyApp';

  /// Whether debug mode is enabled.
  bool debugMode = false;

  /// Private constructor — prevents external instantiation.
  AppConfig._internal();

  /// Returns the sole [AppConfig] instance.
  factory AppConfig() => _instance;
}

void main() {
  final config1 = AppConfig();
  final config2 = AppConfig();
  config1.debugMode = true;

  print(identical(config1, config2)); // true — same instance
  print(config2.debugMode); // true — change reflected
}
