/// Demonstrates the **State** pattern.
///
/// Allows an object to change its behavior when its internal state
/// changes. The object appears to change its class.
library;

// DART EXAMPLE

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
  void next(Order order) =>
      // اكتمل بالفعل!
      print('Already completed!');
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
  // --- 📦 تتبع حالة الطلب
  print('Order State Tracker ---');
  final order = Order();
  // الحالة الأولى
  print('Initial State: ${order.state.status}');

  // \nتحديث الحالة...
  print('Proceeding to next state...');
  order.proceed();
  // الحالة الجديدة
  print('New State: ${order.state.status}');

  // \nتحديث الحالة...
  print('Proceeding to next state...');
  order.proceed();
  // الحالة النهائية
  print('Final State: ${order.state.status}');
}
