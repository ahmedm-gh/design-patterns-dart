/// Demonstrates the **Bridge** pattern.
///
/// Decouples an abstraction from its implementation so that both
/// can vary independently. Uses composition instead of inheritance.
library;

// --- التنفيذ ---
// --- Implementor ---
abstract class MessageSender {
  void sendMessage(String message);
}

class SmsSender implements MessageSender {
  @override
  void sendMessage(String message) => print('SMS: $message');
}

class EmailSender implements MessageSender {
  @override
  void sendMessage(String message) => print('Email: $message');
}

// --- التجريد ---
// --- Abstraction ---
class NotificationManager {
  final MessageSender _sender;
  NotificationManager(this._sender);

  void notify(String message) => _sender.sendMessage(message);
}

// --- التجريد المُنقَّح ---
// --- Refined Abstraction ---
class UrgentNotification extends NotificationManager {
  UrgentNotification(super.sender);

  @override
  void notify(String message) => super.notify('🚨 عاجل | URGENT: $message');
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 🌁 جسر الإشعارات | Notification Bridge ---');
  print('تجهيز إشعار عاجل عبر الرسائل القصيرة... | Preparing urgent SMS...');
  final urgentSms = UrgentNotification(SmsSender());
  urgentSms.notify('الخادم توقف! | Server down!');
}
