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

abstract class ShapeVisitor {
  void visitCircle(Circle circle);
  void visitRectangle(Rectangle rectangle);
}

class AreaCalculator implements ShapeVisitor {
  @override
  void visitCircle(Circle c) =>
      print('Circle area: ${3.14159 * c.radius * c.radius}');

  @override
  void visitRectangle(Rectangle r) =>
      print('Rectangle area: ${r.width * r.height}');
}


void main() {
  // --- Usage ---
  final shapes = <Shape>[Circle(5), Rectangle(4, 6)];
  final calculator = AreaCalculator();

  for (final shape in shapes) {
    shape.accept(calculator);
  }
  // Circle area: 78.53975
  // Rectangle area: 24.0
}
