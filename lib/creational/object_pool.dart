/// Demonstrates the **Object Pool** pattern.
///
/// Manages a pool of reusable objects to avoid the cost of repeated
/// creation and destruction.
library;

class DatabaseConnection {
  final int id;
  bool inUse = false;

  DatabaseConnection(this.id) {
    print('⏳ Creating connection #$id (expensive!)');
  }

  String query(String sql) => 'Connection #$id: $sql';
}

class ConnectionPool {
  final List<DatabaseConnection> _pool = [];
  int _nextId = 1;
  final int maxSize;

  ConnectionPool({this.maxSize = 3});

  // الاستحواذ — إعادة استخدام أو إنشاء جديد
  // Acquire — reuse or create new
  DatabaseConnection acquire() {
    for (final conn in _pool) {
      if (!conn.inUse) {
        conn.inUse = true;
        print('♻️ Reusing connection #${conn.id}');
        return conn;
      }
    }
    if (_pool.length < maxSize) {
      final conn = DatabaseConnection(_nextId++)..inUse = true;
      _pool.add(conn);
      return conn;
    }
    throw StateError('Pool exhausted!');
  }

  // التحرير — إعادة للتجمُّع
  // Release — return to pool
  void release(DatabaseConnection connection) {
    connection.inUse = false;
    print('🔓 Released connection #${connection.id}');
  }
}

void main() {
  print('--- ♻️ تجمُّع الكائنات | Object Pool ---');
  final pool = ConnectionPool(maxSize: 2);

  print('طلب أول اتصال...');
  final conn1 = pool.acquire(); // ⏳ Creating connection #1
  print('طلب ثاني اتصال...');
  final conn2 = pool.acquire(); // ⏳ Creating connection #2

  print('\nتنفيذ استعلام... | Executing query...');
  print(conn1.query('SELECT * FROM users'));

  print('\nإعادة الاتصال الأول للتجمُّع... | Releasing first connection...');
  pool.release(conn1); // 🔓 Released connection #1

  print('طلب اتصال ثالث... | Requesting third connection...');
  final conn3 = pool.acquire(); // ♻️ Reusing connection #1

  print(
    'هل الاتصال 3 هو نفسه 1؟ | Is conn3 same as conn1? ${identical(conn1, conn3)}',
  ); // true
  pool.release(conn2);
  pool.release(conn3);
}
