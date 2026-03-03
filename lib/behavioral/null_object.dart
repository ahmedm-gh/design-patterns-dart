/// Demonstrates the **Null Object** pattern.
///
/// Provides a default "do-nothing" object instead of `null`,
/// eliminating the need for null checks.
library;

abstract class Logger {
  void log(String message);
}

class ConsoleLogger implements Logger {
  @override
  void log(String message) => print('📝 LOG: $message');
}

// الكائن الفارغ — لا يفعل شيئًا
// Null Object — does nothing
class NullLogger implements Logger {
  const NullLogger();
  @override
  void log(String message) {
    /* لا شيء | nothing */
  }
}

class PaymentService {
  final Logger _logger;

  // لا حاجة لفحص null — NullLogger هو الافتراضي
  // No null check needed — NullLogger is the default
  PaymentService({Logger logger = const NullLogger()}) : _logger = logger;

  void processPayment(double amount) {
    _logger.log('Processing: \$${amount.toStringAsFixed(2)}');
    print('💰 Payment of \$${amount.toStringAsFixed(2)} processed');
    _logger.log('Completed');
  }
}

void main() {
  print('--- 👻 الكائن الفارغ | Null Object ---');
  // مع تسجيل | With logging
  print('1. الدفع مع استخدام مسجل (Logger) حقيقي:');
  PaymentService(logger: ConsoleLogger()).processPayment(99.99);

  print('\n---\n');

  // بدون تسجيل — بلا فحوصات null!
  // Without logging — no null checks needed!
  print('2. الدفع بدون أداة تسجيل (استخدام الكائن الفارغ الافتراضي):');
  PaymentService().processPayment(49.99);
}
