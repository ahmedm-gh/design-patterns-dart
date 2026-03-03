class AppConfig {
  // Dart guarantees static final fields are initialized once (lazy by default)
  static final AppConfig _instance = AppConfig._internal();

  String appName = 'MyApp';
  bool debugMode = false;

  // Private constructor — no external instantiation
  AppConfig._internal();

  // Factory constructor always returns the same instance
  factory AppConfig() => _instance;
}


void main() {
  // --- Usage ---
  final config1 = AppConfig();
  final config2 = AppConfig();
  config1.debugMode = true;

  print(identical(config1, config2)); // true — same instance
  print(config2.debugMode);           // true — change reflected
}
