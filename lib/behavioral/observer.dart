/// Demonstrates the **Observer** pattern.
///
/// Defines a one-to-many dependency so that when one object changes
/// state, all dependents are notified automatically.
library;

class EventEmitter<T> {
  final _listeners = <void Function(T)>[];

  // الاشتراك | Subscribe
  void on(void Function(T) listener) => _listeners.add(listener);
  // إلغاء الاشتراك | Unsubscribe
  void off(void Function(T) listener) => _listeners.remove(listener);
  // إخطار الجميع | Notify all
  void emit(T event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 👀 المُراقِب | Observer ---');
  final priceTracker = EventEmitter<double>();

  print('إضافة مراقب للسعر... | Adding price observer...');
  priceTracker.on((price) => print('📊 السعر الجديد | New price: \$$price'));

  print('إضافة مراقب للتنبيهات... | Adding alert observer...');
  priceTracker.on((price) {
    if (price < 50)
      print('� تنبيه: السعر منخفض جدًا! | Alert: Price is too low!');
  });

  print('\nتحديث السعر إلى 75 | Updating price to 75:');
  priceTracker.emit(75.0);

  print('\nتحديث السعر إلى 45 | Updating price to 45:');
  priceTracker.emit(45.0);
}
