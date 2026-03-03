class Pizza {
  String? size;
  String? crust;
  List<String> toppings = [];

  @override
  String toString() => 'Pizza($size, $crust, toppings: $toppings)';
}

class PizzaBuilder {
  final Pizza _pizza = Pizza();

  PizzaBuilder setSize(String size) {
    _pizza.size = size;
    return this; // Enables method chaining
  }

  PizzaBuilder setCrust(String crust) {
    _pizza.crust = crust;
    return this;
  }

  PizzaBuilder addTopping(String topping) {
    _pizza.toppings.add(topping);
    return this;
  }

  Pizza build() => _pizza;
}


void main() {
  // --- Usage ---
  final pizza = PizzaBuilder()
      .setSize('Large')
      .setCrust('Thin')
      .addTopping('Cheese')
      .addTopping('Olives')
      .build();

  print(pizza); // Pizza(Large, Thin, toppings: [Cheese, Olives])
}
