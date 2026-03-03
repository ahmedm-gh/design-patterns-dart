abstract class Coffee {
  String get description;
  double get cost;
}

class SimpleCoffee implements Coffee {
  @override
  String get description => 'Simple Coffee';
  @override
  double get cost => 5.0;
}

// --- Decorators ---
class MilkDecorator implements Coffee {
  final Coffee _coffee;
  MilkDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + Milk';
  @override
  double get cost => _coffee.cost + 1.5;
}

class SugarDecorator implements Coffee {
  final Coffee _coffee;
  SugarDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + Sugar';
  @override
  double get cost => _coffee.cost + 0.5;
}


void main() {
  // --- Usage ---
  Coffee order = SimpleCoffee();
  order = MilkDecorator(order);
  order = SugarDecorator(order);

  print(order.description); // Simple Coffee + Milk + Sugar
  print(order.cost);        // 7.0
}
