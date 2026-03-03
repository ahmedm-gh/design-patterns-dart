/// Demonstrates the **Builder** pattern.
///
/// Separates the construction of a complex object from its representation,
/// allowing step-by-step construction.
library;

/// A pizza with configurable options.
class Pizza {
  /// The size of the pizza.
  String? size;

  /// The crust type.
  String? crust;

  /// The list of toppings.
  final List<String> toppings = [];

  @override
  String toString() => 'Pizza($size, $crust, toppings: $toppings)';
}

/// Builds a [Pizza] step by step using method chaining.
class PizzaBuilder {
  final Pizza _pizza = Pizza();

  /// Sets the pizza [size].
  PizzaBuilder setSize(String size) {
    _pizza.size = size;
    return this;
  }

  /// Sets the [crust] type.
  PizzaBuilder setCrust(String crust) {
    _pizza.crust = crust;
    return this;
  }

  /// Adds a [topping] to the pizza.
  PizzaBuilder addTopping(String topping) {
    _pizza.toppings.add(topping);
    return this;
  }

  /// Returns the constructed [Pizza].
  Pizza build() => _pizza;
}

void main() {
  final pizza = PizzaBuilder()
      .setSize('Large')
      .setCrust('Thin')
      .addTopping('Cheese')
      .addTopping('Olives')
      .build();

  print(pizza); // Pizza(Large, Thin, toppings: [Cheese, Olives])
}
