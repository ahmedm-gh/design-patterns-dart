class EventEmitter<T> {
  final _listeners = <void Function(T)>[];

  void on(void Function(T) listener) => _listeners.add(listener);
  void off(void Function(T) listener) => _listeners.remove(listener);
  void emit(T event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }
}


void main() {
  // --- Usage ---
  final priceTracker = EventEmitter<double>();

  priceTracker.on((price) => print('📊 New price: $price'));
  priceTracker.on((price) {
    if (price < 50) print('🔔 Alert: Price is low!');
  });

  priceTracker.emit(75.0); // 📊 New price: 75.0
  priceTracker.emit(45.0); // 📊 New price: 45.0  +  🔔 Alert: Price is low!
}
