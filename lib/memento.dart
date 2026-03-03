/// Demonstrates the **Memento** pattern.
///
/// Captures an object's internal state in a snapshot so it can be
/// restored later without violating encapsulation.
library;

/// An immutable snapshot of an [Editor]'s content.
final class EditorMemento {
  /// The saved content.
  final String content;

  /// Creates a memento with the given [content].
  const EditorMemento(this.content);
}

/// A text editor whose state can be saved and restored.
class Editor {
  /// The current text content.
  String content = '';

  /// Saves the current state and returns a [EditorMemento].
  EditorMemento save() => EditorMemento(content);

  /// Restores this editor's state from the given [memento].
  void restore(EditorMemento memento) => content = memento.content;
}

/// A caretaker that manages a stack of [EditorMemento] snapshots.
class History {
  final _snapshots = <EditorMemento>[];

  /// Pushes a [memento] onto the history stack.
  void push(EditorMemento memento) => _snapshots.add(memento);

  /// Pops and returns the most recent snapshot, or `null` if empty.
  EditorMemento? pop() =>
      _snapshots.isNotEmpty ? _snapshots.removeLast() : null;
}

void main() {
  final editor = Editor();
  final history = History();

  editor.content = 'Chapter 1';
  history.push(editor.save());

  editor.content = 'Chapter 2';
  history.push(editor.save());

  editor.content = 'Wrong text!';

  // Restore last snapshot
  editor.restore(history.pop()!);
  print(editor.content); // Chapter 2
}
