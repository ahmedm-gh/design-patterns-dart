/// Demonstrates the **Repository** pattern.
///
/// Abstracts data access behind a collection-like interface,
/// decoupling domain logic from storage details.
library;

/// A user entity.
final class User {
  /// The unique identifier.
  final int id;

  /// The user's name.
  final String name;

  /// The user's email.
  final String email;

  /// Creates a user.
  const User({required this.id, required this.name, required this.email});

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}

/// An abstract repository for [User] entities.
abstract interface class UserRepository {
  /// Returns all users.
  List<User> findAll();

  /// Returns the user with the given [id], or `null` if not found.
  User? findById(int id);

  /// Saves a [user] (insert or update).
  void save(User user);

  /// Deletes the user with the given [id].
  void delete(int id);
}

/// An in-memory implementation of [UserRepository].
final class InMemoryUserRepository implements UserRepository {
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
  final UserRepository repo = InMemoryUserRepository();

  // Create
  repo.save(const User(id: 1, name: 'Ali', email: 'ali@mail.com'));
  repo.save(const User(id: 2, name: 'Sara', email: 'sara@mail.com'));

  // Read
  print('All: ${repo.findAll()}');
  print('Find #1: ${repo.findById(1)}');

  // Delete
  repo.delete(2);
  print('After delete: ${repo.findAll()}');
}
