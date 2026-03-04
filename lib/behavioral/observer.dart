/// Demonstrates the **Observer** pattern.
///
/// Defines a one-to-many dependency so that when one object changes
/// state, all dependents are notified automatically.
library;

// DART EXAMPLE

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
  // --- 👀 المُراقِب
  print('Observer ---');
  final priceTracker = EventEmitter<double>();

  // إضافة مراقب للسعر...
  print('Adding price observer...');
  priceTracker.on(
    (price) => // 📊 السعر الجديد
        print('New price: \$$price'),
  );

  // إضافة مراقب للتنبيهات...
  print('Adding alert observer...');
  priceTracker.on((price) {
    if (price < 50) {
      // � تنبيه: السعر منخفض جدًا!
      print('Alert: Price is too low!');
    }
  });

  // تحديث السعر إلى 75
  print('Updating price to 75:');
  priceTracker.emit(75.0);

  // تحديث السعر إلى 45
  print('Updating price to 45:');
  priceTracker.emit(45.0);
}
