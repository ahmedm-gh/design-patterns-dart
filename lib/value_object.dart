/// Demonstrates the **Value Object** pattern.
///
/// An immutable object whose equality is based on its value,
/// not its identity. Two value objects with the same data are equal.
library;

/// An immutable monetary amount with a currency.
final class Money {
  /// The numeric amount.
  final double amount;

  /// The currency code (e.g., 'USD', 'SAR').
  final String currency;

  /// Creates a money value with the given [amount] and [currency].
  const Money(this.amount, this.currency);

  /// Adds this money to [other].
  ///
  /// Throws [ArgumentError] if currencies don't match.
  Money operator +(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot add $currency and ${other.currency}');
    }
    return Money(amount + other.amount, currency);
  }

  /// Multiplies this money by a [factor].
  Money operator *(num factor) => Money(amount * factor, currency);

  @override
  bool operator ==(Object other) =>
      other is Money && amount == other.amount && currency == other.currency;

  @override
  int get hashCode => Object.hash(amount, currency);

  @override
  String toString() => '${amount.toStringAsFixed(2)} $currency';
}

/// An immutable 2D point.
final class Point {
  /// The x-coordinate.
  final double x;

  /// The y-coordinate.
  final double y;

  /// Creates a point at ([x], [y]).
  const Point(this.x, this.y);

  /// Returns the distance from this point to [other].
  double distanceTo(Point other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return (dx * dx + dy * dy).toDouble();
  }

  @override
  bool operator ==(Object other) =>
      other is Point && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point($x, $y)';
}

void main() {
  // Money value objects
  const price = Money(29.99, 'SAR');
  const tax = Money(4.50, 'SAR');
  final total = price + tax;
  print('Total: $total'); // Total: 34.49 SAR

  final doubled = price * 2;
  print('Doubled: $doubled'); // Doubled: 59.98 SAR

  // Equality by value, not identity
  print(const Money(10, 'SAR') == const Money(10, 'SAR')); // true
  print(const Point(3, 4) == const Point(3, 4)); // true
  print(const Point(3, 4) == const Point(5, 6)); // false
}
