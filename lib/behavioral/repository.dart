/// Demonstrates the **Repository** pattern.
///
/// Abstracts data access behind a collection-like interface,
/// decoupling domain logic from storage details.
library;

// DART EXAMPLE

class User {
  final int id;
  final String name;
  final String email;
  const User({required this.id, required this.name, required this.email});

  @override
  String toString() => 'User($id, $name)';
}

// واجهة المستودع — مُجرَّدة عن التخزين
// Repository interface — abstracted from storage
abstract class UserRepository {
  List<User> findAll();
  User? findById(int id);
  void save(User user);
  void delete(int id);
}

// تنفيذ في الذاكرة — يمكن استبداله بقاعدة بيانات أو API
// In-memory implementation — can be swapped with DB or API
class InMemoryUserRepository implements UserRepository {
  final Map<int, User> _store = {};

  @override
  List<User> findAll() => _store.values.toList();
  @override
  User? findById(int id) => _store[id];
  @override
  void save(User user) => _store[user.id] = user;
  @override
  void delete(int id) => _store.remove(id);
}

void main() {
  // --- 🗄️ المستودع
  print('Repository ---');
  // تهيئة مستودع في الذاكرة...
  print('Initializing in-memory repo...');
  final UserRepository repo = InMemoryUserRepository();

  // حفظ مستخدمين جدد...
  print('Saving new users...');
  repo.save(const User(id: 1, name: 'Ali', email: 'ali@mail.com'));
  repo.save(const User(id: 2, name: 'Sara', email: 'sara@mail.com'));

  // جميع المستخدمين
  print('All users:');
  repo.findAll().forEach((u) => print('  - \$u'));

  // البحث عن المستخدم رقم 1
  print('Find user #1:');
  print('  -> \${repo.findById(1)}');

  // حذف المستخدم رقم 2...
  print('Deleting user #2...');
  repo.delete(2);

  // المستخدمون بعد الحذف
  print('Users after delete:');
  repo.findAll().forEach((u) => print('  - \$u'));
}
