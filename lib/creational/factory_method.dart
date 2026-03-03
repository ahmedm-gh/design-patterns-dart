/// Demonstrates the **Factory Method** pattern.
///
/// Defines an interface for creating an object, but lets subclasses
/// decide which class to instantiate.
library;

/// A notification that can be sent with a message.
abstract interface class Notification {
  /// Sends the given [message].
  void send(String message);
}

/// Sends notifications via email.
final class EmailNotification implements Notification {
  /// Creates an email notification.
  const EmailNotification();

  @override
  void send(String message) => print('Email: $message');
}

/// Sends notifications via SMS.
final class SmsNotification implements Notification {
  /// Creates an SMS notification.
  const SmsNotification();

  @override
  void send(String message) => print('SMS: $message');
}

/// Sends push notifications.
final class PushNotification implements Notification {
  /// Creates a push notification.
  const PushNotification();

  @override
  void send(String message) => print('Push: $message');
}

/// Creates a [Notification] based on the given [type].
///
/// Throws [ArgumentError] if [type] is unknown.
Notification createNotification(String type) {
  return switch (type) {
    'email' => const EmailNotification(),
    'sms' => const SmsNotification(),
    'push' => const PushNotification(),
    _ => throw ArgumentError('Unknown notification type: $type'),
  };
}

void main() {
  final notification = createNotification('email');
  notification.send('Hello!'); // Email: Hello!
}
