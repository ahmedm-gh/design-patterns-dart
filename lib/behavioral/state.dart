/// Demonstrates the **State** pattern.
///
/// Allows an object to change its behavior when its internal state
/// changes. The object appears to change its class.
library;

/// Represents a state in the order lifecycle.
abstract interface class OrderState {
  /// Transitions the [order] to its next state.
  void next(Order order);

  /// A human-readable label for this state.
  String get status;
}

/// The initial state — order is waiting to be processed.
final class PendingState implements OrderState {
  /// Creates a pending state.
  const PendingState();

  @override
  void next(Order order) => order.state = const ProcessingState();

  @override
  String get status => 'Pending';
}

/// The order is being processed.
final class ProcessingState implements OrderState {
  /// Creates a processing state.
  const ProcessingState();

  @override
  void next(Order order) => order.state = const DeliveredState();

  @override
  String get status => 'Processing';
}

/// The order has been delivered (terminal state).
final class DeliveredState implements OrderState {
  /// Creates a delivered state.
  const DeliveredState();

  @override
  void next(Order order) => print('Order already completed!');

  @override
  String get status => 'Delivered';
}

/// An order that transitions through states.
class Order {
  /// The current state of this order.
  OrderState state = const PendingState();

  /// Advances to the next state.
  void proceed() => state.next(this);
}

void main() {
  final order = Order();
  print(order.state.status); // Pending
  order.proceed();
  print(order.state.status); // Processing
  order.proceed();
  print(order.state.status); // Delivered
}
