/// Demonstrates the **Proxy** pattern.
///
/// Provides a surrogate for another object to control access to it.
library;

/// A database that can execute SQL queries.
abstract interface class Database {
  /// Executes the given [sql] query and returns the results.
  String query(String sql);
}

/// A real database connection.
final class RealDatabase implements Database {
  /// Creates a real database connection.
  RealDatabase() {
    print('⏳ Connecting to database...');
  }

  @override
  String query(String sql) => 'Results: $sql';
}

/// A proxy that lazily initializes and logs access to a [RealDatabase].
final class DatabaseProxy implements Database {
  RealDatabase? _db;

  @override
  String query(String sql) {
    // Lazy initialization — connects on first query only.
    _db ??= RealDatabase();
    print('📋 Logging query: $sql');
    return _db!.query(sql);
  }
}

void main() {
  final db = DatabaseProxy(); // Not connected yet
  print(db.query('SELECT * FROM users'));
  // ⏳ Connecting to database...
  // 📋 Logging query: SELECT * FROM users
  // Results: SELECT * FROM users
}
