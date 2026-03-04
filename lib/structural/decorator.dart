/// Demonstrates the **Decorator** pattern.
///
/// Attaches additional responsibilities to an object dynamically
/// without modifying its class.
library;

// DART EXAMPLE

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
  // --- ☕ تحضير القهوة
  print('Preparing Coffee ---');
  Coffee order = SimpleCoffee();
  // 1. ${order.description}
  print('السعر: \$${order.cost}');

  order = MilkDecorator(order);
  // 2. إضافة حليب
  print('Adding milk -> السعر: \$${order.cost}');

  order = SugarDecorator(order);
  // 3. إضافة سكر
  print('Adding sugar -> السعر: \$${order.cost}');

  // ✅ الطلب النهائي
  print('Final Order:');
  // ${order.description}
  print('الإجمالي: \$${order.cost}');
}
