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

// --- Abstraction ---
class NotificationManager {
  final MessageSender _sender;
  NotificationManager(this._sender);

  void notify(String message) => _sender.sendMessage(message);
}

class UrgentNotification extends NotificationManager {
  UrgentNotification(super.sender);

  @override
  void notify(String message) => super.notify('🚨 URGENT: $message');
}


void main() {
  // --- Usage ---
  final urgentSms = UrgentNotification(SmsSender());
  urgentSms.notify('Server down!'); // SMS: 🚨 URGENT: Server down!
}
