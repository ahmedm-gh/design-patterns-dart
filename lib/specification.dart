/// Demonstrates the **Specification** pattern.
///
/// Encapsulates business rules as composable, reusable objects
/// that can be combined with AND, OR, and NOT operators.
library;

/// A specification that tests whether a candidate of type [T] satisfies
/// a business rule.
abstract class Specification<T> {
  /// Whether [candidate] satisfies this specification.
  bool isSatisfiedBy(T candidate);

  /// Combines this specification with [other] using logical AND.
  Specification<T> and(Specification<T> other) => _AndSpec(this, other);

  /// Combines this specification with [other] using logical OR.
  Specification<T> or(Specification<T> other) => _OrSpec(this, other);

  /// Negates this specification.
  Specification<T> not() => _NotSpec(this);
}

final class _AndSpec<T> extends Specification<T> {
  final Specification<T> _left, _right;
  _AndSpec(this._left, this._right);

  @override
  bool isSatisfiedBy(T candidate) =>
      _left.isSatisfiedBy(candidate) && _right.isSatisfiedBy(candidate);
}

final class _OrSpec<T> extends Specification<T> {
  final Specification<T> _left, _right;
  _OrSpec(this._left, this._right);

  @override
  bool isSatisfiedBy(T candidate) =>
      _left.isSatisfiedBy(candidate) || _right.isSatisfiedBy(candidate);
}

final class _NotSpec<T> extends Specification<T> {
  final Specification<T> _spec;
  _NotSpec(this._spec);

  @override
  bool isSatisfiedBy(T candidate) => !_spec.isSatisfiedBy(candidate);
}

// --- Domain Example ---

/// A product with a name, price, and category.
final class Product {
  /// The product name.
  final String name;

  /// The price in dollars.
  final double price;

  /// The product category.
  final String category;

  /// Creates a product.
  const Product(this.name, this.price, this.category);

  @override
  String toString() => '$name (\$$price, $category)';
}

/// Matches products under a given [maxPrice].
final class CheapProduct extends Specification<Product> {
  /// The maximum price threshold.
  final double maxPrice;

  /// Creates a specification for products under [maxPrice].
  CheapProduct(this.maxPrice);

  @override
  bool isSatisfiedBy(Product p) => p.price <= maxPrice;
}

/// Matches products in a given [category].
final class InCategory extends Specification<Product> {
  /// The target category.
  final String category;

  /// Creates a specification for products in [category].
  InCategory(this.category);

  @override
  bool isSatisfiedBy(Product p) => p.category == category;
}

void main() {
  final products = [
    const Product('Phone', 999, 'Electronics'),
    const Product('Book', 15, 'Education'),
    const Product('Cable', 8, 'Electronics'),
    const Product('Laptop', 1500, 'Electronics'),
    const Product('Pen', 2, 'Education'),
  ];

  // Composable business rules
  final cheapElectronics = CheapProduct(50).and(InCategory('Electronics'));
  final educationOrCheap = InCategory('Education').or(CheapProduct(10));

  print('Cheap Electronics:');
  products.where(cheapElectronics.isSatisfiedBy).forEach(print);
  // Cable ($8.0, Electronics)

  print('\nEducation OR Cheap:');
  products.where(educationOrCheap.isSatisfiedBy).forEach(print);
  // Book ($15.0, Education)
  // Cable ($8.0, Electronics)
  // Pen ($2.0, Education)
}
