/// Demonstrates the **Dependency Injection** pattern.
///
/// Provides dependencies from the outside instead of having classes
/// create their own, improving testability and flexibility.
library;

/// A service for sending emails.
abstract interface class EmailService {
  /// Sends an email to [to] with the given [body].
  void send(String to, String body);
}

/// A real email service that sends actual emails.
final class SmtpEmailService implements EmailService {
  @override
  void send(String to, String body) => print('📧 SMTP → $to: $body');
}

/// A fake email service for testing.
final class FakeEmailService implements EmailService {
  /// The list of sent emails for verification.
  final sent = <String>[];

  @override
  void send(String to, String body) {
    sent.add('$to: $body');
    print('🧪 Fake → $to: $body');
  }
}

/// A service that handles user registration.
///
/// Receives its [EmailService] dependency via **constructor injection**.
class UserService {
  final EmailService _emailService;

  /// Creates a user service with the given [emailService].
  UserService(EmailService emailService) : _emailService = emailService;

  /// Registers a new user with the given [email].
  void register(String email) {
    print('✅ User registered: $email');
    _emailService.send(email, 'Welcome!');
  }
}

void main() {
  // Production: inject real service
  final prodService = UserService(SmtpEmailService());
  prodService.register('user@example.com');
  // ✅ User registered: user@example.com
  // 📧 SMTP → user@example.com: Welcome!

  print('---');

  // Testing: inject fake service
  final fakeEmail = FakeEmailService();
  final testService = UserService(fakeEmail);
  testService.register('test@example.com');
  // ✅ User registered: test@example.com
  // 🧪 Fake → test@example.com: Welcome!

  print('Sent emails: ${fakeEmail.sent}');
}
