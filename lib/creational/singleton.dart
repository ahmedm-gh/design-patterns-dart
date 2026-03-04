/// Demonstrates the **Singleton** pattern.
///
/// Ensures a class has only one instance throughout the application's
/// lifetime and provides a global access point to it.
library;

// DART EXAMPLE

class AppConfig {
  // Dart يضمن التهيئة مرة واحدة
  // Dart guarantees static final fields are initialized once
  static final AppConfig _instance = AppConfig._internal();

  String appName = 'MyApp';
  bool debugMode = false;

  // مُنشئ خاص — لا يمكن إنشاء نُسخ من خارج الصنف
  // Private constructor — no external instantiation
  AppConfig._internal();

  // مُنشئ المصنع يُرجع النسخة الوحيدة دائمًا
  // Factory constructor always returns the same instance
  factory AppConfig() => _instance;
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  // --- 🌍 طلب نسخة الإعدادات الأولى
  print('Requesting first config instance ---');
  final config1 = AppConfig();

  // --- 🌍 طلب نسخة أخرى
  print('Requesting second config instance ---');
  final config2 = AppConfig();

  // تعديل النسخة الأولى...
  print('Modifying first instance...');
  config1.debugMode = true;

  // هل النسختان متطابقتان في الذاكرة؟
  print('Are instances identical in memory?');
  print(identical(config1, config2)); // true — نفس النسخة | same instance

  // تأثير التعديل على النسخة الثانية
  print('Modification effect on second instance:');
  // وضع التصحيح
  print('Debug Mode = ${config2.debugMode}'); // true
}
