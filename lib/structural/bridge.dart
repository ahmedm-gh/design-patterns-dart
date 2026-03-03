/// Demonstrates the **Bridge** pattern.
///
/// Decouples an abstraction from its implementation so that both
/// can vary independently. Uses composition instead of inheritance.
library;

/// The implementor interface for sending messages.
abstract interface class MessageSender {
  /// Sends the given [message].
  void sendMessage(String message);
}

/// Sends messages via SMS.
final class SmsSender implements MessageSender {
  /// Creates an SMS sender.
  const SmsSender();

  @override
  void sendMessage(String message) => print('SMS: $message');
}

/// Sends messages via email.
final class EmailSender implements MessageSender {
  /// Creates an email sender.
  const EmailSender();

  @override
  void sendMessage(String message) => print('Email: $message');
}

/// Manages notifications using a pluggable [MessageSender].
class NotificationManager {
  final MessageSender _sender;

  /// Creates a notification manager with the given [sender].
  NotificationManager(MessageSender sender) : _sender = sender;

  /// Sends a notification with the given [message].
  void notify(String message) => _sender.sendMessage(message);
}

/// An urgent notification that prefixes messages with a warning.
class UrgentNotification extends NotificationManager {
  /// Creates an urgent notification with the given [sender].
  UrgentNotification(super.sender);

  @override
  void notify(String message) => super.notify('🚨 URGENT: $message');
}

void main() {
  final urgentSms = UrgentNotification(const SmsSender());
  urgentSms.notify('Server down!'); // SMS: 🚨 URGENT: Server down!
}
