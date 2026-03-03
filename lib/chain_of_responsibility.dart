/// Demonstrates the **Chain of Responsibility** pattern.
///
/// Passes a request along a chain of handlers. Each handler either
/// processes it or forwards it to the next handler.
library;

/// A handler in a support chain.
abstract class SupportHandler {
  SupportHandler? _next;

  /// Sets the [handler] as the next in the chain and returns it.
  SupportHandler setNext(SupportHandler handler) {
    _next = handler;
    return handler;
  }

  /// Handles the given [issue], or forwards it to the next handler.
  String handle(String issue) {
    if (_next != null) return _next!.handle(issue);
    return '❌ Unresolved issue: $issue';
  }
}

/// Handles common issues automatically.
final class BotSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'password_reset') return '🤖 Password reset link sent';
    return super.handle(issue);
  }
}

/// Handles issues that require human intervention.
final class HumanSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'billing') {
      return '👨‍💼 Transferring to billing department';
    }
    return super.handle(issue);
  }
}

void main() {
  final bot = BotSupport();
  bot.setNext(HumanSupport());

  print(bot.handle('password_reset')); // 🤖 Password reset link sent
  print(bot.handle('billing')); // 👨‍💼 Transferring to billing department
  print(bot.handle('unknown')); // ❌ Unresolved issue: unknown
}
