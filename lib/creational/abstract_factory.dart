/// Demonstrates the **Abstract Factory** pattern.
///
/// Provides an interface for creating families of related objects
/// without specifying their concrete classes.
library;

// DART EXAMPLE

// --- المُنتَجات المُجرَّدة ---
// --- Abstract Products ---
abstract class Connection {
  String connect();
}

abstract class Command {
  String execute();
}

// --- المُنتَجات الفعلية ---
// --- Concrete Products ---
class MySqlConnection implements Connection {
  @override
  String connect() => '[MySQL Connection]';
}

class PostgreSqlConnection implements Connection {
  @override
  String connect() => '[PostgreSQL Connection]';
}

class MySqlCommand implements Command {
  @override
  String execute() => '[MySQL Command]';
}

class PostgreSqlCommand implements Command {
  @override
  String execute() => '[PostgreSQL Command]';
}

// --- المصنع المُجرَّد ---
// --- Abstract Factory ---
abstract class DatabaseFactory {
  Connection createConnection();
  Command createCommand();
}

// --- المصانع الفعلية ---
// --- Concrete Factories ---
class MySqlFactory implements DatabaseFactory {
  @override
  Connection createConnection() => MySqlConnection();
  @override
  Command createCommand() => MySqlCommand();
}

class PostgreSqlFactory implements DatabaseFactory {
  @override
  Connection createConnection() => PostgreSqlConnection();
  @override
  Command createCommand() => PostgreSqlCommand();
}

// --- الاستخدام ---
// --- Usage ---
void executeOperations(DatabaseFactory factory) {
  // --- 🛠️ تنفيذ العمليات
  print('Executing DB Operations ---');
  final connection = factory.createConnection();
  final command = factory.createCommand();
  print('🔌 ${connection.connect()}');
  print('⚡ ${command.execute()}');
}

void main() {
  // 🐬 استخدام مصنع MySQL
  print('Using MySqlFactory:');
  executeOperations(MySqlFactory());

  // 🐘 استخدام مصنع PostgreSQL
  print('Using PostgreSqlFactory:');
  executeOperations(PostgreSqlFactory());
}
