/// Demonstrates the **Composite** pattern.
///
/// Lets you treat individual objects and groups of objects uniformly
/// through a tree structure.
library;

// --- الواجهة المشتركة ---
// --- Shared Interface ---
abstract class FileSystemEntity {
  String get name;
  int getSize();
}

// --- الورقة ---
// --- Leaf ---
class File implements FileSystemEntity {
  @override
  final String name;
  final int size;
  File(this.name, this.size);

  @override
  int getSize() => size;
}

// --- المُركَّب ---
// --- Composite ---
class Folder implements FileSystemEntity {
  @override
  final String name;
  final List<FileSystemEntity> _children = [];
  Folder(this.name);

  void add(FileSystemEntity entity) => _children.add(entity);

  @override
  int getSize() => _children.fold(0, (sum, e) => sum + e.getSize());
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 🗂️ حساب حجم المجلدات | Calculating Folders Size ---');
  final root = Folder('root')
    ..add(File('readme.md', 100))
    ..add(
      Folder('src')
        ..add(File('main.dart', 500))
        ..add(File('utils.dart', 300)),
    );

  print('حجم "readme.md" هو 100 | Size of readme.md = 100');
  print('حجم المجلد الداخلي "src" هو 800 | Size of src = 800');
  print(
    '📁 إجمالي حجم المجلد الأم | Total root size: ${root.getSize()} byte',
  ); // 900
}
