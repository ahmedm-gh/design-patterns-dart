/// Demonstrates the **Builder** pattern.
///
/// Separates the construction of a complex object from its representation,
/// allowing step-by-step construction.
library;

// DART EXAMPLE

class Pizza {
  String? size;
  String? crust;
  List<String> toppings = [];

  @override
  String toString() => 'Pizza($size, $crust, toppings: $toppings)';
}

class PizzaBuilder {
  final Pizza _pizza = Pizza();

  // تحديد الحجم | Set size
  PizzaBuilder setSize(String size) {
    _pizza.size = size;
    return this; // لتمكين سلسلة الاستدعاءات | Enables method chaining
  }

  // تحديد العجينة | Set crust
  PizzaBuilder setCrust(String crust) {
    _pizza.crust = crust;
    return this;
  }

  // إضافة طبقة | Add topping
  PizzaBuilder addTopping(String topping) {
    _pizza.toppings.add(topping);
    return this;
  }

  // بناء المُنتَج النهائي | Build final product
  Pizza build() => _pizza;
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  // --- 🍕 بناء بيتزا مخصصة
  print('Building Custom Pizza ---');
  // جارٍ إضافة المكونات...
  print('Adding ingredients...');

  final pizza = PizzaBuilder()
      .setSize('Large')
      .setCrust('Thin')
      .addTopping('Cheese')
      .addTopping('Olives')
      .build();

  // ✅ النتيجة النهائية
  print('Final Result: $pizza');
}
