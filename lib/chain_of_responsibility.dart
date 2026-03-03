abstract class SupportHandler {
  SupportHandler? _next;

  SupportHandler setNext(SupportHandler handler) {
    _next = handler;
    return handler;
  }

  String handle(String issue) {
    if (_next != null) return _next!.handle(issue);
    return '❌ Unresolved issue: $issue';
  }
}

class BotSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'password_reset') return '🤖 Password reset link sent';
    return super.handle(issue);
  }
}

class HumanSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'billing') return '👨‍💼 Transferring to billing department';
    return super.handle(issue);
  }
}


void main() {
  // --- Usage ---
  final bot = BotSupport();
  bot.setNext(HumanSupport());

  print(bot.handle('password_reset')); // 🤖 Password reset link sent
  print(bot.handle('billing'));        // 👨‍💼 Transferring to billing department
  print(bot.handle('unknown'));        // ❌ Unresolved issue: unknown
}
