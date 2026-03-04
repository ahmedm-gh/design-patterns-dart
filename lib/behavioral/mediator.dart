/// Demonstrates the **Mediator** pattern.
///
/// Reduces direct coupling by making objects communicate through
/// a mediator instead of directly with each other.
library;

// DART EXAMPLE

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
      // $name تلقّى من
      print('received from $from: $message');
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  // --- 💬 غرفة الدردشة
  print('Chat Room Mediator ---');
  final room = ChatRoom();
  final ali = User('Ali');
  final sara = User('Sara');

  // تسجيل علي وسارة في الغرفة...
  print('Registering Ali and Sara...');
  room
    ..register(ali)
    ..register(sara);

  // \nعلي يُرسل رسالة
  print('Ali sends a message:');
  ali.send('مرحبًا! | Hello!');
}
