/// Demonstrates the **Proxy** pattern.
///
/// Provides a surrogate for another object to control access to it.
library;

// DART EXAMPLE

abstract class Database {
  String query(String sql);
}

class RealDatabase implements Database {
  RealDatabase() {
    // ⏳ جاري الاتصال...
    print('Connecting...');
  }
  @override
  String query(String sql) => 'نتائج | Results: $sql';
}

class DatabaseProxy implements Database {
  RealDatabase? _db;

  @override
  String query(String sql) {
    // التهيئة الكسولة — الاتصال عند أول استعلام فقط
    // Lazy initialization — connects on first query only
    _db ??= RealDatabase();
    // 📋 تسجيل
    print('Logging: $sql');
    return _db!.query(sql);
  }
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  // --- 🛡️ استخدام الوكيل
  print('Using Proxy ---');
  final db = DatabaseProxy(); // لم يتصل بعد | Not connected yet
  print('تم إنشاء الوكيل، لكن لم يتم الاتصال بقاعدة البيانات بعد.');
  print('Proxy created, but database not connected yet.\n');

  // إرسال أول استعلام...
  print('Sending first query...');
  print(db.query('SELECT * FROM users'));
}
