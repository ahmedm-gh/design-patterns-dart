/// Demonstrates the **Null Object** pattern.
///
/// Provides a default "do-nothing" object instead of `null`,
/// eliminating the need for null checks.
library;

/// A logger interface.
abstract interface class Logger {
  /// Logs the given [message].
  void log(String message);
}

/// A logger that writes to the console.
final class ConsoleLogger implements Logger {
  /// Creates a console logger.
  const ConsoleLogger();

  @override
  void log(String message) => print('📝 LOG: $message');
}

/// A **Null Object** logger that silently discards all messages.
///
/// Clients can use this instead of `null` to avoid null checks.
final class NullLogger implements Logger {
  /// Creates a null logger.
  const NullLogger();

  @override
  void log(String message) {
    // Intentionally do nothing.
  }
}

/// A service that optionally logs its operations.
class PaymentService {
  final Logger _logger;

  /// Creates a payment service with the given [logger].
  ///
  /// Uses [NullLogger] by default — no null checks needed.
  PaymentService({Logger logger = const NullLogger()}) : _logger = logger;

  /// Processes a payment of the given [amount].
  void processPayment(double amount) {
    _logger.log('Processing payment: \$${amount.toStringAsFixed(2)}');
    // ... payment logic ...
    _logger.log('Payment completed');
    print('💰 Payment of \$${amount.toStringAsFixed(2)} processed');
  }
}

void main() {
  // With logging
  print('--- With Logger ---');
  final service1 = PaymentService(logger: const ConsoleLogger());
  service1.processPayment(99.99);

  print('');

  // Without logging — no null checks needed!
  print('--- Without Logger (Null Object) ---');
  final service2 = PaymentService(); // Uses NullLogger by default
  service2.processPayment(49.99);
}
