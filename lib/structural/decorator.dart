/// Demonstrates the **Decorator** pattern.
///
/// Attaches additional responsibilities to an object dynamically
/// without modifying its class.
library;

// --- الواجهة الأساسية ---
// --- Base Interface ---
abstract class Coffee {
  String get description;
  double get cost;
}

class SimpleCoffee implements Coffee {
  @override
  String get description => 'قهوة بسيطة | Simple Coffee';
  @override
  double get cost => 5.0;
}

// --- مُزخرِفات ---
// --- Decorators ---
class MilkDecorator implements Coffee {
  final Coffee _coffee;
  MilkDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + حليب | Milk';
  @override
  double get cost => _coffee.cost + 1.5;
}

class SugarDecorator implements Coffee {
  final Coffee _coffee;
  SugarDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + سكر | Sugar';
  @override
  double get cost => _coffee.cost + 0.5;
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- ☕ تحضير القهوة | Preparing Coffee ---');
  Coffee order = SimpleCoffee();
  print('1. ${order.description} | السعر: \$${order.cost}');

  order = MilkDecorator(order);
  print('2. إضافة حليب | Adding milk -> السعر: \$${order.cost}');

  order = SugarDecorator(order);
  print('3. إضافة سكر | Adding sugar -> السعر: \$${order.cost}');

  print('\n✅ الطلب النهائي | Final Order:');
  print('${order.description} | الإجمالي: \$${order.cost}');
}
