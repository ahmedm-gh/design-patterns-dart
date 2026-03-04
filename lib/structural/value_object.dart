/// Demonstrates the **Value Object** pattern.
///
/// An immutable object whose equality is based on its value,
/// not its identity. Two value objects with the same data are equal.
library;

// DART EXAMPLE

class Money {
  final double amount;
  final String currency;
  const Money(this.amount, this.currency);

  Money operator +(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot add $currency and ${other.currency}');
    }
    return Money(amount + other.amount, currency);
  }

  Money operator *(num factor) => Money(amount * factor, currency);

  // المساواة بالقيمة — ليس بالهوية
  // Equality by value — not by identity
  @override
  bool operator ==(Object other) =>
      other is Money && amount == other.amount && currency == other.currency;

  @override
  int get hashCode => Object.hash(amount, currency);

  @override
  String toString() => '${amount.toStringAsFixed(2)} $currency';
}

void main() {
  // --- 💎 كائن القيمة
  print('Value Object ---');
  const price = Money(29.99, 'SAR');
  const tax = Money(4.50, 'SAR');

  // السعر
  print('Price: $price');
  // الضريبة
  print('Tax: $tax');

  final total = price + tax;
  // \nالإجمالي
  print('Total: $total'); // Total: 34.49 SAR
  // الضعف
  print('Double price: ${price * 2}'); // 59.98 SAR

  // \nالمساواة بالقيمة؟
  print('Value equality?');
  final m1 = const Money(10, 'SAR');
  final m2 = const Money(10, 'SAR');
  print('هل (10 SAR) == (10 SAR)؟ ${m1 == m2}'); // true
}
