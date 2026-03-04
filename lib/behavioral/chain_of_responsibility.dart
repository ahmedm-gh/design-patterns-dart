/// Demonstrates the **Chain of Responsibility** pattern.
///
/// Passes a request along a chain of handlers. Each handler either
/// processes it or forwards it to the next handler.
library;

// DART EXAMPLE

abstract class SupportHandler {
  SupportHandler? _next;

  // تحديد المُعالِج التالي
  // Set the next handler
  SupportHandler setNext(SupportHandler handler) {
    _next = handler;
    return handler;
  }

  String handle(String issue) {
    if (_next != null) return _next!.handle(issue);
    return '❌ لم يتم الحل | Unresolved: $issue';
  }
}

class BotSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'password_reset') return '🤖 تم إرسال الرابط | Link sent';
    return super.handle(issue);
  }
}

class HumanSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'billing')
      return '👨‍💼 تحويل للفوترة | Transferring to billing';
    return super.handle(issue);
  }
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  // --- ⛓️ سلسلة المسؤولية
  print('Chain of Responsibility ---');
  final bot = BotSupport();
  bot.setNext(HumanSupport());

  // \nإرسال طلب استعادة كلمة المرور
  print('Requesting password reset:');
  // النتيجة
  print('Result: ${bot.handle('password_reset')}');

  // \nإرسال طلب فواتير
  print('Requesting billing details:');
  // النتيجة
  print('Result: ${bot.handle('billing')}');

  // \nإرسال طلب غير معروف
  print('Requesting unknown issue:');
  // النتيجة
  print('Result: ${bot.handle('unknown')}');
}
