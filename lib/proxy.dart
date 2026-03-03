abstract class Database {
  String query(String sql);
}

class RealDatabase implements Database {
  RealDatabase() {
    print('⏳ Connecting to database...');
  }
  @override
  String query(String sql) => 'Results: $sql';
}

class DatabaseProxy implements Database {
  RealDatabase? _db;

  @override
  String query(String sql) {
    // Lazy initialization — connects on first query only
    _db ??= RealDatabase();
    print('📋 Logging query: $sql');
    return _db!.query(sql);
  }
}


void main() {
  // --- Usage ---
  final db = DatabaseProxy(); // Not connected yet
  print(db.query('SELECT * FROM users')); // Connects now, then logs and executes
}
