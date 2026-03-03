/// Demonstrates the **Object Pool** pattern.
///
/// Manages a pool of reusable objects to avoid the cost of repeated
/// creation and destruction.
library;

/// A database connection that is expensive to create.
final class DatabaseConnection {
  /// A unique identifier for this connection.
  final int id;

  /// Whether this connection is currently in use.
  bool inUse = false;

  /// Creates a connection with the given [id].
  DatabaseConnection(this.id) {
    print('⏳ Creating connection #$id (expensive!)');
  }

  /// Executes the given [sql] query.
  String query(String sql) => 'Connection #$id: $sql';
}

/// A pool that reuses [DatabaseConnection] instances.
class ConnectionPool {
  final List<DatabaseConnection> _pool = [];
  int _nextId = 1;

  /// The maximum number of connections in the pool.
  final int maxSize;

  /// Creates a pool with the given [maxSize].
  ConnectionPool({this.maxSize = 3});

  /// Acquires a connection from the pool, creating one if needed.
  ///
  /// Throws [StateError] if the pool is exhausted.
  DatabaseConnection acquire() {
    // Try to find an available connection.
    for (final conn in _pool) {
      if (!conn.inUse) {
        conn.inUse = true;
        print('♻️ Reusing connection #${conn.id}');
        return conn;
      }
    }

    // Create a new one if pool isn't full.
    if (_pool.length < maxSize) {
      final conn = DatabaseConnection(_nextId++)..inUse = true;
      _pool.add(conn);
      return conn;
    }

    throw StateError('Pool exhausted! Max size: $maxSize');
  }

  /// Releases a [connection] back to the pool.
  void release(DatabaseConnection connection) {
    connection.inUse = false;
    print('🔓 Released connection #${connection.id}');
  }
}

void main() {
  final pool = ConnectionPool(maxSize: 2);

  final conn1 = pool.acquire(); // ⏳ Creating connection #1
  final conn2 = pool.acquire(); // ⏳ Creating connection #2
  print(conn1.query('SELECT * FROM users'));

  pool.release(conn1); // 🔓 Released connection #1

  final conn3 = pool.acquire(); // ♻️ Reusing connection #1
  print(identical(conn1, conn3)); // true — same object reused
  pool.release(conn2);
  pool.release(conn3);
}
