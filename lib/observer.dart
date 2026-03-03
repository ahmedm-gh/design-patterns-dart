/// Demonstrates the **Observer** pattern.
///
/// Defines a one-to-many dependency so that when one object changes
/// state, all dependents are notified automatically.
library;

/// A generic event emitter that notifies listeners of type [T] events.
class EventEmitter<T> {
  final _listeners = <void Function(T)>[];

  /// Registers a [listener] to be called on each event.
  void on(void Function(T) listener) => _listeners.add(listener);

  /// Removes a previously registered [listener].
  void off(void Function(T) listener) => _listeners.remove(listener);

  /// Emits an [event], notifying all registered listeners.
  void emit(T event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }
}

void main() {
  final priceTracker = EventEmitter<double>();

  priceTracker.on((price) => print('📊 New price: $price'));
  priceTracker.on((price) {
    if (price < 50) print('🔔 Alert: Price is low!');
  });

  priceTracker.emit(75.0); // 📊 New price: 75.0
  priceTracker.emit(45.0); // 📊 New price: 45.0  +  🔔 Alert: Price is low!
}
