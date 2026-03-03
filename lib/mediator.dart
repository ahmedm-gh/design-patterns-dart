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

class User {
  final String name;
  ChatRoom? _room;
  User(this.name);

  void send(String message) => _room?.sendMessage(message, this);
  void receive(String message, String from) =>
      print('$name received from $from: $message');
}


void main() {
  // --- Usage ---
  final room = ChatRoom();
  final ali = User('Ali');
  final sara = User('Sara');
  room..register(ali)..register(sara);

  ali.send('Hello!'); // Sara received from Ali: Hello!
}
