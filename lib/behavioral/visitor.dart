/// Demonstrates the **Visitor** pattern.
///
/// Separates operations from object structure, allowing new
/// operations without modifying element classes.
library;

import 'dart:math' as math;

/// A geometric shape that accepts a [ShapeVisitor].
abstract interface class Shape {
  /// Accepts the given [visitor] for double-dispatch.
  void accept(ShapeVisitor visitor);
}

/// A circle with a given [radius].
final class Circle implements Shape {
  /// The radius of this circle.
  final double radius;

  /// Creates a circle with the given [radius].
  const Circle(this.radius);

  @override
  void accept(ShapeVisitor visitor) => visitor.visitCircle(this);
}

/// A rectangle with a given [width] and [height].
final class Rectangle implements Shape {
  /// The width of this rectangle.
  final double width;

  /// The height of this rectangle.
  final double height;

  /// Creates a rectangle with the given [width] and [height].
  const Rectangle(this.width, this.height);

  @override
  void accept(ShapeVisitor visitor) => visitor.visitRectangle(this);
}

/// A visitor that can operate on various [Shape] types.
abstract interface class ShapeVisitor {
  /// Visits a [circle].
  void visitCircle(Circle circle);

  /// Visits a [rectangle].
  void visitRectangle(Rectangle rectangle);
}

/// Calculates and prints the area of each shape.
final class AreaCalculator implements ShapeVisitor {
  /// Creates an area calculator.
  const AreaCalculator();

  @override
  void visitCircle(Circle c) =>
      print('Circle area: ${math.pi * c.radius * c.radius}');

  @override
  void visitRectangle(Rectangle r) =>
      print('Rectangle area: ${r.width * r.height}');
}

void main() {
  final shapes = <Shape>[const Circle(5), const Rectangle(4, 6)];
  const calculator = AreaCalculator();

  for (final shape in shapes) {
    shape.accept(calculator);
  }
  // Circle area: 78.53981633974483
  // Rectangle area: 24.0
}
