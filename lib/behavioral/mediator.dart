/// Demonstrates the **Mediator** pattern.
///
/// Reduces direct coupling by making objects communicate through
/// a mediator instead of directly with each other.
library;

/// A chat room that mediates communication between users.
class ChatRoom {
  final List<User> _users = [];

  /// Registers a [user] in this chat room.
  void register(User user) {
    _users.add(user);
    user._room = this;
  }

  /// Broadcasts a [message] from [sender] to all other users.
  void sendMessage(String message, User sender) {
    for (final user in _users) {
      if (user != sender) user.receive(message, sender.name);
    }
  }
}

/// A user that communicates through a [ChatRoom].
class User {
  /// The user's display name.
  final String name;

  ChatRoom? _room;

  /// Creates a user with the given [name].
  User(this.name);

  /// Sends a [message] to the chat room.
  void send(String message) => _room?.sendMessage(message, this);

  /// Receives a [message] from another user named [from].
  void receive(String message, String from) =>
      print('$name received from $from: $message');
}

void main() {
  final room = ChatRoom();
  final ali = User('Ali');
  final sara = User('Sara');
  room
    ..register(ali)
    ..register(sara);

  ali.send('Hello!'); // Sara received from Ali: Hello!
}
