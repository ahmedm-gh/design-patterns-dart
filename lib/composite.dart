abstract class FileSystemEntity {
  String get name;
  int getSize();
}

class File implements FileSystemEntity {
  @override
  final String name;
  final int size;
  File(this.name, this.size);

  @override
  int getSize() => size;
}

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
  // --- Usage ---
  final root = Folder('root')
    ..add(File('readme.md', 100))
    ..add(Folder('src')..add(File('main.dart', 500))..add(File('utils.dart', 300)));

  print(root.getSize()); // 900
}
