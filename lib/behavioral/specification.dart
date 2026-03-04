/// Demonstrates the **Specification** pattern.
///
/// Encapsulates business rules as composable, reusable objects
/// that can be combined with AND, OR, and NOT operators.
library;

// DART EXAMPLE

abstract class Specification<T> {
  bool isSatisfiedBy(T candidate);

  // التركيب — AND, OR, NOT
  // Composition — AND, OR, NOT
  Specification<T> and(Specification<T> other) => _AndSpec(this, other);
  Specification<T> or(Specification<T> other) => _OrSpec(this, other);
  Specification<T> not() => _NotSpec(this);
}

class _AndSpec<T> extends Specification<T> {
  final Specification<T> _left, _right;
  _AndSpec(this._left, this._right);
  @override
  bool isSatisfiedBy(T c) => _left.isSatisfiedBy(c) && _right.isSatisfiedBy(c);
}

class _OrSpec<T> extends Specification<T> {
  final Specification<T> _left, _right;
  _OrSpec(this._left, this._right);
  @override
  bool isSatisfiedBy(T c) => _left.isSatisfiedBy(c) || _right.isSatisfiedBy(c);
}

class _NotSpec<T> extends Specification<T> {
  final Specification<T> _spec;
  _NotSpec(this._spec);
  @override
  bool isSatisfiedBy(T c) => !_spec.isSatisfiedBy(c);
}

// --- المجال | Domain ---

class Product {
  final String name;
  final double price;
  final String category;
  const Product(this.name, this.price, this.category);

  @override
  String toString() => '$name (\$$price, $category)';
}

class CheapProduct extends Specification<Product> {
  final double maxPrice;
  CheapProduct(this.maxPrice);
  @override
  bool isSatisfiedBy(Product p) => p.price <= maxPrice;
}

class InCategory extends Specification<Product> {
  final String category;
  InCategory(this.category);
  @override
  bool isSatisfiedBy(Product p) => p.category == category;
}

void main() {
  // --- 📋 المواصفة
  print('Specification ---');
  final products = [
    const Product('Phone', 999, 'Electronics'),
    const Product('Book', 15, 'Education'),
    const Product('Cable', 8, 'Electronics'),
    const Product('Pen', 2, 'Education'),
  ];

  // المنتجات المتاحة
  print('Available products:');
  for (final p in products) {
    print('  - $p');
  }

  // قواعد عمل قابلة للتركيب
  // Composable business rules
  print('\nقاعدة التصفية: إلكترونيات وسعرها 50 أو أقل');
  print('Filter rule: Electronics AND price <= 50');
  final cheapElectronics = CheapProduct(50).and(InCategory('Electronics'));

  // ✅ الإلكترونيات الرخيصة المطابقة
  print('Matching Cheap Electronics:');
  for (final p in products.where(cheapElectronics.isSatisfiedBy)) {
    print('  -> $p');
  }
}
