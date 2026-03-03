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
  // --- Usage ---
  final editor = TextEditor();
  final commands = <Command>[];

  final cmd1 = TypeCommand(editor, 'Hello ');
  final cmd2 = TypeCommand(editor, 'World!');

  cmd1.execute();
  cmd2.execute();
  commands.addAll([cmd1, cmd2]);
  print(editor.content); // Hello World!

  commands.removeLast().undo();
  print(editor.content); // Hello
}
