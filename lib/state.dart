abstract class OrderState {
  void next(Order order);
  String get status;
}

class PendingState implements OrderState {
  @override
  void next(Order order) => order.state = ProcessingState();
  @override
  String get status => 'Pending';
}

class ProcessingState implements OrderState {
  @override
  void next(Order order) => order.state = DeliveredState();
  @override
  String get status => 'Processing';
}

class DeliveredState implements OrderState {
  @override
  void next(Order order) => print('Order already completed!');
  @override
  String get status => 'Delivered';
}

class Order {
  OrderState state = PendingState();
  void proceed() => state.next(this);
}


void main() {
  // --- Usage ---
  final order = Order();
  print(order.state.status); // Pending
  order.proceed();
  print(order.state.status); // Processing
  order.proceed();
  print(order.state.status); // Delivered
}
