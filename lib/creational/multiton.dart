/// Demonstrates the **Multiton** pattern.
///
/// Like Singleton, but manages a registry of named instances.
/// Each key maps to exactly one instance.
library;

// DART EXAMPLE

class Logger {
  static final Map<String, Logger> _instances = {};

  final String channel;
  Logger._internal(this.channel);

  // مصنع يُرجع نسخة واحدة لكل قناة
  // Factory returns one instance per channel
  factory Logger(String channel) {
    return _instances.putIfAbsent(channel, () {
      print('🆕 Creating logger for "$channel"');
      return Logger._internal(channel);
    });
  }

  void log(String message) => print('[$channel] $message');
}

void main() {
  // --- 👯 المُتعدِّد
  print('Multiton ---');
  print('جلب مسجل المصادقة (أول مرة)...');
  final authLogger1 = Logger('auth'); // 🆕 Creating

  print('جلب مسجل المصادقة (ثاني مرة)...');
  final authLogger2 = Logger('auth'); // مُعاد استخدام | Reused

  print('جلب مسجل قاعدة البيانات...');
  final dbLogger = Logger('database'); // 🆕 Creating

  // هل مسجل المصادقة 1 و 2 متطابقان؟
  print('Are auth 1 and 2 identical? ${identical(authLogger1, authLogger2)}');
  // هل مسجل المصادقة وقاعدة البيانات متطابقان؟
  print('Are auth and db identical? ${identical(authLogger1, dbLogger)}');

  print('');
  authLogger1.log('User logged in'); // [auth] User logged in
  dbLogger.log('Query executed'); // [database] Query executed
}
