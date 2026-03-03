/// Demonstrates the **Mediator** pattern.
///
/// Reduces direct coupling by making objects communicate through
/// a mediator instead of directly with each other.
library;

// --- الوسيط ---
// --- Mediator ---
class ChatRoom {
  final List<User> _users = [];

  void register(User user) {
    _users.add(user);
    user._room = this;
  }

  void sendMessage(String message, User sender) {
    for (final user in _users) {
      if (user != sender) user.receive(message, sender.name);
    }
  }
}

// --- الزميل ---
// --- Colleague ---
class User {
  final String name;
  ChatRoom? _room;
  User(this.name);

  void send(String message) => _room?.sendMessage(message, this);
  void receive(String message, String from) =>
      print('$name تلقّى من | received from $from: $message');
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 💬 غرفة الدردشة | Chat Room Mediator ---');
  final room = ChatRoom();
  final ali = User('Ali');
  final sara = User('Sara');

  print('تسجيل علي وسارة في الغرفة... | Registering Ali and Sara...');
  room
    ..register(ali)
    ..register(sara);

  print('\nعلي يُرسل رسالة | Ali sends a message:');
  ali.send('مرحبًا! | Hello!');
}
