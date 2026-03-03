/// Demonstrates the **Interpreter** pattern.
///
/// Defines a representation for a language's grammar and an
/// interpreter to evaluate its sentences.
library;

abstract class Expression {
  int interpret(Map<String, int> context);
}

// --- تعبير نهائي — متغيِّر ---
// --- Terminal — variable ---
class NumberExp implements Expression {
  final String variable;
  NumberExp(this.variable);

  @override
  int interpret(Map<String, int> context) => context[variable] ?? 0;
}

// --- تعبير غير نهائي — جمع ---
// --- Non-terminal — addition ---
class AddExp implements Expression {
  final Expression left, right;
  AddExp(this.left, this.right);

  @override
  int interpret(Map<String, int> context) =>
      left.interpret(context) + right.interpret(context);
}

void main() {
  // --- الاستخدام: x + y ---
  // --- Usage: x + y ---
  print('--- 🧮 المُفسِّر | Interpreter ---');
  final expression = AddExp(NumberExp('x'), NumberExp('y'));
  print('تعبير | Expression: x + y');
  print('مع سياق | With context: {x: 10, y: 20}');

  final result = expression.interpret({'x': 10, 'y': 20});
  print('✅ النتيجة | Result: $result'); // 30
}
