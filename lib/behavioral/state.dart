/// Demonstrates the **State** pattern.
///
/// Allows an object to change its behavior when its internal state
/// changes. The object appears to change its class.
library;

abstract class OrderState {
  void next(Order order);
  String get status;
}

class PendingState implements OrderState {
  @override
  void next(Order order) => order.state = ProcessingState();
  @override
  String get status => 'قيد الانتظار | Pending';
}

class ProcessingState implements OrderState {
  @override
  void next(Order order) => order.state = DeliveredState();
  @override
  String get status => 'قيد المعالجة | Processing';
}

class DeliveredState implements OrderState {
  @override
  void next(Order order) => print('اكتمل بالفعل! | Already completed!');
  @override
  String get status => 'تم التوصيل | Delivered';
}

class Order {
  OrderState state = PendingState();
  void proceed() => state.next(this);
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 📦 تتبع حالة الطلب | Order State Tracker ---');
  final order = Order();
  print('الحالة الأولى | Initial State: ${order.state.status}');

  print('\nتحديث الحالة... | Proceeding to next state...');
  order.proceed();
  print('الحالة الجديدة | New State: ${order.state.status}');

  print('\nتحديث الحالة... | Proceeding to next state...');
  order.proceed();
  print('الحالة النهائية | Final State: ${order.state.status}');
}
