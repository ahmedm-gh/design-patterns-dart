/// Demonstrates the **Composite** pattern.
///
/// Lets you treat individual objects and groups of objects uniformly
/// through a tree structure.
library;

/// A shared interface for files and folders.
abstract interface class FileSystemEntity {
  /// The name of this entity.
  String get name;

  /// Returns the total size in bytes.
  int getSize();
}

/// A file with a fixed size (leaf node).
final class File implements FileSystemEntity {
  @override
  final String name;

  /// The size of this file in bytes.
  final int size;

  /// Creates a file with the given [name] and [size].
  const File(this.name, this.size);

  @override
  int getSize() => size;
}

/// A folder that can contain other [FileSystemEntity] children (composite node).
final class Folder implements FileSystemEntity {
  @override
  final String name;

  final List<FileSystemEntity> _children = [];

  /// Creates a folder with the given [name].
  Folder(this.name);

  /// Adds a child [entity] to this folder.
  void add(FileSystemEntity entity) => _children.add(entity);

  @override
  int getSize() => _children.fold(0, (sum, e) => sum + e.getSize());
}

void main() {
  final root = Folder('root')
    ..add(const File('readme.md', 100))
    ..add(
      Folder('src')
        ..add(const File('main.dart', 500))
        ..add(const File('utils.dart', 300)),
    );

  print(root.getSize()); // 900
}
