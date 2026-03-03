abstract class Expression {
  int interpret(Map<String, int> context);
}

class NumberExp implements Expression {
  final String variable;
  NumberExp(this.variable);

  @override
  int interpret(Map<String, int> context) => context[variable] ?? 0;
}

class AddExp implements Expression {
  final Expression left, right;
  AddExp(this.left, this.right);

  @override
  int interpret(Map<String, int> context) =>
      left.interpret(context) + right.interpret(context);
}


void main() {
  // --- Usage: x + y ---
  final expression = AddExp(NumberExp('x'), NumberExp('y'));
  print(expression.interpret({'x': 10, 'y': 20})); // 30
}
