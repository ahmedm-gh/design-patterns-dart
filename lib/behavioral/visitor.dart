/// Demonstrates the **Visitor** pattern.
///
/// Separates operations from object structure, allowing new
/// operations without modifying element classes.
library;

// --- العناصر ---
// --- Elements ---
abstract class Shape {
  void accept(ShapeVisitor visitor);
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);

  @override
  void accept(ShapeVisitor visitor) => visitor.visitCircle(this);
}

class Rectangle implements Shape {
  final double width, height;
  Rectangle(this.width, this.height);

  @override
  void accept(ShapeVisitor visitor) => visitor.visitRectangle(this);
}

// --- الزائر ---
// --- Visitor ---
abstract class ShapeVisitor {
  void visitCircle(Circle circle);
  void visitRectangle(Rectangle rectangle);
}

// --- زائر حساب المساحة ---
// --- Area Calculator Visitor ---
class AreaCalculator implements ShapeVisitor {
  @override
  void visitCircle(Circle c) =>
      print('مساحة الدائرة | Circle area: ${3.14159 * c.radius * c.radius}');

  @override
  void visitRectangle(Rectangle r) =>
      print('مساحة المستطيل | Rectangle area: ${r.width * r.height}');
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 🚶‍♂️ الزائر (حساب المساحات) | Visitor (Area Calculation) ---');
  final shapes = <Shape>[Circle(5), Rectangle(4, 6)];
  print(
    'الأشكال: دائرة (5)، مستطيل (4x6) | Shapes: Circle(5), Rectangle(4, 6)\n',
  );

  final calculator = AreaCalculator();

  for (final shape in shapes) {
    shape.accept(calculator);
  }
}
