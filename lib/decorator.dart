/// Demonstrates the **Decorator** pattern.
///
/// Attaches additional responsibilities to an object dynamically
/// without modifying its class.
library;

/// A coffee drink with a description and cost.
abstract interface class Coffee {
  /// A human-readable description of this coffee.
  String get description;

  /// The total cost of this coffee.
  double get cost;
}

/// A simple, undecorated coffee.
final class SimpleCoffee implements Coffee {
  /// Creates a simple coffee.
  const SimpleCoffee();

  @override
  String get description => 'Simple Coffee';

  @override
  double get cost => 5.0;
}

/// Adds milk to a [Coffee].
final class MilkDecorator implements Coffee {
  final Coffee _coffee;

  /// Creates a milk decorator wrapping the given [coffee].
  const MilkDecorator(Coffee coffee) : _coffee = coffee;

  @override
  String get description => '${_coffee.description} + Milk';

  @override
  double get cost => _coffee.cost + 1.5;
}

/// Adds sugar to a [Coffee].
final class SugarDecorator implements Coffee {
  final Coffee _coffee;

  /// Creates a sugar decorator wrapping the given [coffee].
  const SugarDecorator(Coffee coffee) : _coffee = coffee;

  @override
  String get description => '${_coffee.description} + Sugar';

  @override
  double get cost => _coffee.cost + 0.5;
}

void main() {
  Coffee order = const SimpleCoffee();
  order = MilkDecorator(order);
  order = SugarDecorator(order);

  print(order.description); // Simple Coffee + Milk + Sugar
  print(order.cost); // 7.0
}
