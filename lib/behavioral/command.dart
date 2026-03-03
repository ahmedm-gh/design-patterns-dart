/// Demonstrates the **Command** pattern.
///
/// Encapsulates a request as a standalone object, enabling deferred
/// execution, undo/redo, and logging.
library;

abstract class Command {
  void execute();
  void undo();
}

class TextEditor {
  String content = '';
  void append(String text) => content += text;
  void removeLast(int count) =>
      content = content.substring(0, content.length - count);
}

class TypeCommand implements Command {
  final TextEditor _editor;
  final String _text;
  TypeCommand(this._editor, this._text);

  @override
  void execute() => _editor.append(_text);

  @override
  void undo() => _editor.removeLast(_text.length);
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 📝 محرر النصوص بالأوامر | Text Editor with Commands ---');
  final editor = TextEditor();
  final commands = <Command>[];

  final cmd1 = TypeCommand(editor, 'Hello ');
  final cmd2 = TypeCommand(editor, 'World!');

  print('1. كتابة "Hello "');
  cmd1.execute();
  print('2. كتابة "World!"');
  cmd2.execute();

  commands.addAll([cmd1, cmd2]);
  print(
    '✅ المحتوى الحالي | Current Content: "${editor.content}"',
  ); // Hello World!

  print('\n--- ⏪ تراجع | Undo ---');
  commands.removeLast().undo();
  print(
    '✅ المحتوى بعد التراجع | Content after undo: "${editor.content}"',
  ); // Hello
}
