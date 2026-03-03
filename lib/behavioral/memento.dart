/// Demonstrates the **Memento** pattern.
///
/// Captures an object's internal state in a snapshot so it can be
/// restored later without violating encapsulation.
library;

// --- اللقطة ---
// --- Snapshot ---
class EditorMemento {
  final String content;
  EditorMemento(this.content);
}

// --- المُنشئ ---
// --- Originator ---
class Editor {
  String content = '';

  EditorMemento save() => EditorMemento(content);
  void restore(EditorMemento memento) => content = memento.content;
}

// --- الحارس ---
// --- Caretaker ---
class History {
  final _snapshots = <EditorMemento>[];

  void push(EditorMemento memento) => _snapshots.add(memento);
  EditorMemento? pop() =>
      _snapshots.isNotEmpty ? _snapshots.removeLast() : null;
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 💾 التذكار (حفظ واستعادة) | Memento (Save/Restore) ---');
  final editor = Editor();
  final history = History();

  print('📝 كتابة الفصل الأول... | Writing Chapter 1...');
  editor.content = 'الفصل الأول | Chapter 1';
  history.push(editor.save());

  print('📝 كتابة الفصل الثاني... | Writing Chapter 2...');
  editor.content = 'الفصل الثاني | Chapter 2';
  history.push(editor.save());

  print('❌ خطأ مطبعي! | Typo made!');
  editor.content = 'نص خاطئ! | Wrong text!';
  print('المحتوى الحالي | Current content: ${editor.content}');

  print('\n--- ⏪ استعادة اللقطة السابقة | Restoring previous snapshot ---');
  editor.restore(history.pop()!);
  print(
    '✅ المحتوى بعد الاستعادة | Content after restore: ${editor.content}',
  ); // الفصل الثاني | Chapter 2
}
