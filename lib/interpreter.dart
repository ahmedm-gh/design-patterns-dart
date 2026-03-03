/// Demonstrates the **Interpreter** pattern.
///
/// Defines a representation for a language's grammar and an
/// interpreter to evaluate its sentences.
library;

/// An expression that can be interpreted in a given [context].
abstract interface class Expression {
  /// Evaluates this expression using variable values from [context].
  int interpret(Map<String, int> context);
}

/// A terminal expression representing a named variable.
final class NumberExp implements Expression {
  /// The variable name to look up in the context.
  final String variable;

  /// Creates a number expression for the given [variable].
  const NumberExp(this.variable);

  @override
  int interpret(Map<String, int> context) => context[variable] ?? 0;
}

/// A non-terminal expression that adds two sub-expressions.
final class AddExp implements Expression {
  /// The left operand.
  final Expression left;

  /// The right operand.
  final Expression right;

  /// Creates an addition expression with [left] and [right] operands.
  const AddExp(this.left, this.right);

  @override
  int interpret(Map<String, int> context) =>
      left.interpret(context) + right.interpret(context);
}

void main() {
  // Usage: x + y
  final expression = AddExp(NumberExp('x'), NumberExp('y'));
  print(expression.interpret({'x': 10, 'y': 20})); // 30
}
