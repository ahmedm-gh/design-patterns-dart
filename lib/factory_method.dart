abstract class Notification {
  void send(String message);
}

class EmailNotification implements Notification {
  @override
  void send(String message) => print('Email: $message');
}

class SmsNotification implements Notification {
  @override
  void send(String message) => print('SMS: $message');
}

class PushNotification implements Notification {
  @override
  void send(String message) => print('Push: $message');
}

// --- Factory Method ---
Notification createNotification(String type) {
  return switch (type) {
    'email' => EmailNotification(),
    'sms'   => SmsNotification(),
    'push'  => PushNotification(),
    _       => throw ArgumentError('Unknown notification type: $type'),
  };
}


void main() {
  // --- Usage ---
  final notification = createNotification('email');
  notification.send('Hello!'); // Email: Hello!
}
