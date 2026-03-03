/// Demonstrates the **Command** pattern.
///
/// Encapsulates a request as a standalone object, enabling deferred
/// execution, undo/redo, and logging.
library;

/// A command that can be executed and undone.
abstract interface class Command {
  /// Executes this command.
  void execute();

  /// Reverses the effect of this command.
  void undo();
}

/// A simple text editor that supports append and remove operations.
class TextEditor {
  /// The current text content.
  String content = '';

  /// Appends [text] to the content.
  void append(String text) => content += text;

  /// Removes the last [count] characters from the content.
  void removeLast(int count) =>
      content = content.substring(0, content.length - count);
}

/// A command that types text into a [TextEditor].
final class TypeCommand implements Command {
  final TextEditor _editor;
  final String _text;

  /// Creates a type command for the given [editor] and [text].
  TypeCommand(this._editor, this._text);

  @override
  void execute() => _editor.append(_text);

  @override
  void undo() => _editor.removeLast(_text.length);
}

void main() {
  final editor = TextEditor();
  final commands = <Command>[];

  final cmd1 = TypeCommand(editor, 'Hello ');
  final cmd2 = TypeCommand(editor, 'World!');

  cmd1.execute();
  cmd2.execute();
  commands.addAll([cmd1, cmd2]);
  print(editor.content); // Hello World!

  // Undo
  commands.removeLast().undo();
  print(editor.content); // Hello
}
