/// Demonstrates the **Dependency Injection** pattern.
///
/// Provides dependencies from the outside instead of having classes
/// create their own, improving testability and flexibility.
library;

// DART EXAMPLE

abstract class EmailService {
  void send(String to, String body);
}

class SmtpEmailService implements EmailService {
  @override
  void send(String to, String body) => print('📧 SMTP → $to: $body');
}

// خدمة وهمية للاختبار | Fake for testing
class FakeEmailService implements EmailService {
  final sent = <String>[];
  @override
  void send(String to, String body) {
    sent.add('$to: $body');
    print('🧪 Fake → $to: $body');
  }
}

// حقن المُنشئ — الاعتمادية تأتي من الخارج
// Constructor Injection — dependency comes from outside
class UserService {
  final EmailService _emailService;
  UserService(this._emailService);

  void register(String email) {
    print('✅ User registered: $email');
    _emailService.send(email, 'Welcome!');
  }
}

void main() {
  // --- 💉 حقن الاعتمادية
  print('Dependency Injection ---');
  // إنتاج: حقن الخدمة الحقيقية | Production: inject real service
  // إنتاج: استخدام خدمة البريد الحقيقية
  print('Production: using SMTP');
  UserService(SmtpEmailService()).register('user@example.com');

  print('\n---\n');

  // اختبار: حقن خدمة وهمية | Testing: inject fake service
  // اختبار: استخدام خدمة بريد وهمية
  print('Testing: using Fake service');
  final fakeEmail = FakeEmailService();
  UserService(fakeEmail).register('test@example.com');
  // قائمة المُرسل إليهم (وهمي)
  print('Sent list (fake): ${fakeEmail.sent}');
}
