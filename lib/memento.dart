class EditorMemento {
  final String content;
  EditorMemento(this.content);
}

class Editor {
  String content = '';

  EditorMemento save() => EditorMemento(content);
  void restore(EditorMemento memento) => content = memento.content;
}

// --- Caretaker ---
class History {
  final _snapshots = <EditorMemento>[];

  void push(EditorMemento memento) => _snapshots.add(memento);
  EditorMemento? pop() => _snapshots.isNotEmpty ? _snapshots.removeLast() : null;
}


void main() {
  // --- Usage ---
  final editor = Editor();
  final history = History();

  editor.content = 'Chapter 1';
  history.push(editor.save());

  editor.content = 'Chapter 2';
  history.push(editor.save());

  editor.content = 'Wrong text!';

  editor.restore(history.pop()!);
  print(editor.content); // Chapter 2
}
