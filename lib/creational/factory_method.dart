/// Demonstrates the **Factory Method** pattern.
///
/// Defines an interface for creating an object, but lets subclasses
/// decide which class to instantiate.
library;

// DART EXAMPLE

// --- واجهة المُنتَج ---
// --- Product Interface ---
abstract class Notification {
  void send(String message);
}

// --- المُنتَجات الفعلية ---
// --- Concrete Products ---
class EmailNotification implements Notification {
  @override
  void send(String message) => print('📧 Email: $message');
}

class SmsNotification implements Notification {
  @override
  void send(String message) => print('📱 SMS: $message');
}

class PushNotification implements Notification {
  @override
  void send(String message) => print('🔔 Push: $message');
}

// --- دالّة المصنع ---
// --- Factory Method ---
Notification createNotification(String type) {
  // --- 🏭 إنشاء إشعار من نوع ($type)
  print('Creating ($type) notification ---');
  return switch (type) {
    'email' => EmailNotification(),
    'sms' => SmsNotification(),
    'push' => PushNotification(),
    _ => throw ArgumentError('نوع غير معروف | Unknown type: $type'),
  };
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final notification = createNotification('email');
  notification.send('مرحبًا بك في تطبيقنا! | Welcome to our app!');
}
