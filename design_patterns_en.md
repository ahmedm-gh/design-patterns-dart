> [النسخة العربية (هنا)](design_patterns_ar.md) | [النسخة المدمجة | BILINGUAL VERSION](design_patterns_bilingual.md)
# Design Patterns

**The 23 Gang of Four (GoF) Design Patterns — Detailed Explanation with Dart Examples**

> Design patterns are proven, reusable solutions to common problems in software design.
> They are not ready-made code, but rather **conceptual templates** that can be applied to various situations.

---

# Part I: Creational Patterns

> **How do we create objects in a flexible and extensible way?**
>
> Instead of directly instantiating objects with `new`, these patterns provide mechanisms to control object creation in a context-appropriate manner.

---

## 1. Abstract Factory

**Description:** Provides an interface for creating **families of related objects** without specifying their concrete classes. Ensures that created products are compatible with each other.

**Problem:** You need to create a set of related objects (e.g., buttons and text fields for a specific platform) without coupling the code to concrete types.

**Solution:** Define an abstract factory interface, then implement concrete factories for each product family.

**Key Terms:**
- **Abstract Factory:** The interface declaring creation methods
- **Concrete Factory:** The implementation that creates a specific family of products
- **Abstract Product:** The shared interface for product types
- **Product Family:** A set of cohesive, compatible objects

```dart
// DART EXAMPLE

// --- Abstract Products ---
abstract class Button {
  String render();
}

abstract class TextField {
  String render();
}

// --- Concrete Products ---
class MaterialButton implements Button {
  @override
  String render() => '[Material Button]';
}

class CupertinoButton implements Button {
  @override
  String render() => '[Cupertino Button]';
}

class MaterialTextField implements TextField {
  @override
  String render() => '[Material TextField]';
}

class CupertinoTextField implements TextField {
  @override
  String render() => '[Cupertino TextField]';
}

// --- Abstract Factory ---
abstract class WidgetFactory {
  Button createButton();
  TextField createTextField();
}

// --- Concrete Factories ---
class MaterialFactory implements WidgetFactory {
  @override
  Button createButton() => MaterialButton();
  @override
  TextField createTextField() => MaterialTextField();
}

class CupertinoFactory implements WidgetFactory {
  @override
  Button createButton() => CupertinoButton();
  @override
  TextField createTextField() => CupertinoTextField();
}

// --- Usage ---
void buildUI(WidgetFactory factory) {
  final button = factory.createButton();
  final textField = factory.createTextField();
  print(button.render());
  print(textField.render());
}

void main() {
  // CupertinoFactory
  buildUI(CupertinoFactory());

  // MaterialFactory
  buildUI(MaterialFactory());
}
```
> 📄 [View source code](lib/abstract_factory.dart)

**When to use?** When your app needs to support multiple platforms or themes with consistent UI components.

---

## 2. Builder

**Description:** Separates the construction of a complex object from its representation, allowing the same construction process to produce different representations. Instead of a massive constructor full of parameters, you build the object **step by step**.

**Problem:** A constructor with dozens of parameters, most of which are optional, making the code hard to read and maintain.

**Solution:** Extract construction steps into a separate Builder object, and optionally use a Director to coordinate the steps.

**Key Terms:**
- **Builder:** The interface defining construction steps
- **Concrete Builder:** The implementation that builds and assembles the parts
- **Director:** Coordinates the order of construction steps (optional)
- **Product:** The final complex object

```dart
// DART EXAMPLE

class Pizza {
  String? size;
  String? crust;
  List<String> toppings = [];

  @override
  String toString() => 'Pizza($size, $crust, toppings: $toppings)';
}

class PizzaBuilder {
  final Pizza _pizza = Pizza();

  PizzaBuilder setSize(String size) {
    _pizza.size = size;
    return this; // Enables method chaining
  }

  PizzaBuilder setCrust(String crust) {
    _pizza.crust = crust;
    return this;
  }

  PizzaBuilder addTopping(String topping) {
    _pizza.toppings.add(topping);
    return this;
  }

  Pizza build() => _pizza;
}


void main() {
  // --- Usage ---
  final pizza = PizzaBuilder()
      .setSize('Large')
      .setCrust('Thin')
      .addTopping('Cheese')
      .addTopping('Olives')
      .build();

  print(pizza); // Pizza(Large, Thin, toppings: [Cheese, Olives])
}
```
> 📄 [View source code](lib/builder.dart)

**When to use?** When you have an object with many diverse construction options.

---

## 3. Factory Method

**Description:** Defines an interface for creating an object, but lets **subclasses decide which class to instantiate**. Turns a direct `new` call into a specialized factory method call.

**Problem:** You want to decouple creation logic from usage code, making it easy to add new types without modifying existing code.

**Solution:** Define a factory method in the parent class and let subclasses override it.

**Key Terms:**
- **Creator:** The class containing the factory method
- **Concrete Creator:** The subclass that implements the factory method
- **Product:** The object returned by the factory method

```dart
// DART EXAMPLE

abstract class Notification {
  void send(String message);
}

class EmailNotification implements Notification {
  @override
  void send(String message) => print('Email: $message');
}

class SmsNotification implements Notification {
  @override
  void send(String message) => print('SMS: $message');
}

class PushNotification implements Notification {
  @override
  void send(String message) => print('Push: $message');
}

// --- Factory Method ---
Notification createNotification(String type) {
  return switch (type) {
    'email' => EmailNotification(),
    'sms'   => SmsNotification(),
    'push'  => PushNotification(),
    _       => throw ArgumentError('Unknown notification type: $type'),
  };
}


void main() {
  // --- Usage ---
  final notification = createNotification('email');
  notification.send('Hello!'); // Email: Hello!
}
```
> 📄 [View source code](lib/factory_method.dart)

**When to use?** When you don't know in advance the exact type of objects your code will create.

---

## 4. Prototype

**Description:** Creates new objects by **cloning** existing ones instead of building from scratch. Useful when object creation is expensive or requires complex setup.

**Problem:** Object creation is costly (e.g., requires database connections or heavy computation), and you need many instances with similar configurations.

**Solution:** Define a `clone()` method that produces an independent copy of the object.

**Key Terms:**
- **Cloning:** Creating a copy of an existing object
- **Deep Copy:** Copying the object and all its nested objects
- **Shallow Copy:** Copying the object but sharing internal references

```dart
// DART EXAMPLE

class GameConfig {
  String difficulty;
  int maxPlayers;
  List<String> enabledModes;

  GameConfig({
    required this.difficulty,
    required this.maxPlayers,
    required this.enabledModes,
  });

  // Deep Copy
  GameConfig clone() {
    return GameConfig(
      difficulty: difficulty,
      maxPlayers: maxPlayers,
      enabledModes: List.from(enabledModes),
    );
  }
}


void main() {
  // --- Usage ---
  final defaultConfig = GameConfig(
    difficulty: 'Normal',
    maxPlayers: 4,
    enabledModes: ['Survival', 'Creative'],
  );

  final customConfig = defaultConfig.clone()
    ..difficulty = 'Hard'
    ..enabledModes.add('Adventure');

  print(defaultConfig.enabledModes); // [Survival, Creative] — unaffected
  print(customConfig.enabledModes);  // [Survival, Creative, Adventure]
}
```
> 📄 [View source code](lib/prototype.dart)

**When to use?** When you want to create similar objects at a lower cost than full construction.

---

## 5. Singleton

**Description:** Ensures a class has **only one instance** throughout the application's lifetime and provides a global access point to it.

**Problem:** You need a single shared instance of a service (e.g., app configuration, database connection), and creating more than one would cause issues.

**Solution:** Make the constructor private and use a static field to hold the sole instance.

**Key Terms:**
- **Global Access Point:** The single way to obtain the instance
- **Lazy Initialization:** Creating the instance upon first request
- **Eager Initialization:** Creating the instance when the class is loaded

```dart
// DART EXAMPLE

class AppConfig {
  // Dart guarantees static final fields are initialized once (lazy by default)
  static final AppConfig _instance = AppConfig._internal();

  String appName = 'MyApp';
  bool debugMode = false;

  // Private constructor — no external instantiation
  AppConfig._internal();

  // Factory constructor always returns the same instance
  factory AppConfig() => _instance;
}


void main() {
  // --- Usage ---
  final config1 = AppConfig();
  final config2 = AppConfig();
  config1.debugMode = true;

  print(identical(config1, config2)); // true — same instance
  print(config2.debugMode);           // true — change reflected
}
```
> 📄 [View source code](lib/singleton.dart)

**When to use?** When you need one shared instance accessible by the entire application.

---

# Part II: Structural Patterns

> **How do we compose objects and classes into larger, flexible structures?**
>
> These patterns focus on organizing relationships between objects to form larger structures while maintaining flexibility.

---

## 6. Adapter

**Description:** Converts one class's interface into another interface expected by the client. Acts as a **compatibility bridge** between two incompatible interfaces.

**Problem:** You have a legacy or third-party API that doesn't conform to your current codebase's interface.

**Solution:** Create a wrapper class that translates calls between the two interfaces.

**Key Terms:**
- **Target:** The interface the client expects
- **Adaptee:** The legacy or external class with an incompatible interface
- **Wrapper:** The adapter class itself

```dart
// DART EXAMPLE

// --- Target Interface ---
abstract class JsonLogger {
  void logJson(Map<String, dynamic> data);
}

// --- Incompatible Legacy Class (Adaptee) ---
class LegacyFileLogger {
  void writeToFile(String text) => print('LOG FILE: $text');
}

// --- Adapter ---
class FileLoggerAdapter implements JsonLogger {
  final LegacyFileLogger _legacyLogger;

  FileLoggerAdapter(this._legacyLogger);

  @override
  void logJson(Map<String, dynamic> data) {
    final text = data.entries.map((e) => '${e.key}=${e.value}').join(', ');
    _legacyLogger.writeToFile(text);
  }
}


void main() {
  // --- Usage ---
  final JsonLogger logger = FileLoggerAdapter(LegacyFileLogger());
  logger.logJson({'event': 'login', 'user': 'ahmad'}); // LOG FILE: event=login, user=ahmad
}
```
> 📄 [View source code](lib/adapter.dart)

**When to use?** When integrating legacy or third-party libraries with your current codebase.

---

## 7. Bridge

**Description:** Decouples an **abstraction** from its **implementation** so that both can vary independently. Uses composition instead of inheritance to avoid class explosion.

**Problem:** Using inheritance for every combination of dimensions (e.g., shape × color) causes an exponential growth in the number of classes.

**Solution:** Separate the two dimensions into independent hierarchies connected via composition.

**Key Terms:**
- **Abstraction:** The high-level interface the client interacts with
- **Implementor:** The interface defining implementation operations
- **Refined Abstraction:** An extension of the base abstraction

```dart
// DART EXAMPLE

// --- Implementor ---
abstract class MessageSender {
  void sendMessage(String message);
}

class SmsSender implements MessageSender {
  @override
  void sendMessage(String message) => print('SMS: $message');
}

class EmailSender implements MessageSender {
  @override
  void sendMessage(String message) => print('Email: $message');
}

// --- Abstraction ---
class NotificationManager {
  final MessageSender _sender;
  NotificationManager(this._sender);

  void notify(String message) => _sender.sendMessage(message);
}

class UrgentNotification extends NotificationManager {
  UrgentNotification(super.sender);

  @override
  void notify(String message) => super.notify('🚨 URGENT: $message');
}


void main() {
  // --- Usage ---
  final urgentSms = UrgentNotification(SmsSender());
  urgentSms.notify('Server down!'); // SMS: 🚨 URGENT: Server down!
}
```
> 📄 [View source code](lib/bridge.dart)

**When to use?** When you have two independent dimensions of variation and want to avoid class explosion.

---

## 8. Composite

**Description:** Lets you treat **individual objects and groups** of objects uniformly through a tree structure. The client doesn't need to distinguish between a single element and a collection.

**Problem:** You have a hierarchical (tree) structure and want to perform operations uniformly on both elements and groups.

**Key Terms:**
- **Component:** The shared interface for leaves and composites
- **Leaf:** A terminal element with no children
- **Composite:** An element containing a group of children

```dart
// DART EXAMPLE

abstract class FileSystemEntity {
  String get name;
  int getSize();
}

class File implements FileSystemEntity {
  @override
  final String name;
  final int size;
  File(this.name, this.size);

  @override
  int getSize() => size;
}

class Folder implements FileSystemEntity {
  @override
  final String name;
  final List<FileSystemEntity> _children = [];
  Folder(this.name);

  void add(FileSystemEntity entity) => _children.add(entity);

  @override
  int getSize() => _children.fold(0, (sum, e) => sum + e.getSize());
}


void main() {
  // --- Usage ---
  final root = Folder('root')
    ..add(File('readme.md', 100))
    ..add(Folder('src')..add(File('main.dart', 500))..add(File('utils.dart', 300)));

  print(root.getSize()); // 900
}
```
> 📄 [View source code](lib/composite.dart)

**When to use?** When dealing with tree structures (files, menus, UI widgets).

---

## 9. Decorator

**Description:** Attaches additional responsibilities to an object **dynamically** without modifying its original class or resorting to excessive inheritance. Wraps the object with an additional layer.

**Problem:** You want to add multiple optional features to an object, and inheritance would produce dozens of classes for every combination.

**Key Terms:**
- **Wrapper:** The decorator object that wraps the original
- **Concrete Decorator:** A specific implementation of the added behavior

```dart
// DART EXAMPLE

abstract class Coffee {
  String get description;
  double get cost;
}

class SimpleCoffee implements Coffee {
  @override
  String get description => 'Simple Coffee';
  @override
  double get cost => 5.0;
}

// --- Decorators ---
class MilkDecorator implements Coffee {
  final Coffee _coffee;
  MilkDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + Milk';
  @override
  double get cost => _coffee.cost + 1.5;
}

class SugarDecorator implements Coffee {
  final Coffee _coffee;
  SugarDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + Sugar';
  @override
  double get cost => _coffee.cost + 0.5;
}


void main() {
  // --- Usage ---
  Coffee order = SimpleCoffee();
  order = MilkDecorator(order);
  order = SugarDecorator(order);

  print(order.description); // Simple Coffee + Milk + Sugar
  print(order.cost);        // 7.0
}
```
> 📄 [View source code](lib/decorator.dart)

**When to use?** When you need to add optional, composable behaviors to an object dynamically.

---

## 10. Facade

**Description:** Provides a simplified, unified interface to a complex subsystem. Hides internal complexity and offers a single, easy-to-use entry point.

**Problem:** A subsystem consists of many intertwined classes, and the client doesn't need to know their details.

**Key Terms:**
- **Subsystem:** The complex set of classes behind the scenes
- **Unified Interface:** The simple entry point for the client

```dart
// DART EXAMPLE

// --- Complex Subsystem Classes ---
class AudioDecoder {
  String decode(String file) => 'audio_data($file)';
}

class VideoDecoder {
  String decode(String file) => 'video_data($file)';
}

class ScreenRenderer {
  void render(String video, String audio) =>
      print('▶ Playing: $video with $audio');
}

// --- Facade ---
class MediaPlayer {
  final _audio = AudioDecoder();
  final _video = VideoDecoder();
  final _renderer = ScreenRenderer();

  void play(String file) {
    final audioData = _audio.decode(file);
    final videoData = _video.decode(file);
    _renderer.render(videoData, audioData);
  }
}


void main() {
  // --- Usage ---
  MediaPlayer().play('movie.mp4'); // ▶ Playing: video_data(movie.mp4) with audio_data(movie.mp4)
}
```
> 📄 [View source code](lib/facade.dart)

**When to use?** When you want to simplify interaction with a complex subsystem.

---

## 11. Flyweight

**Description:** Reduces memory consumption by sharing as much data as possible among similar objects. Separates **shared intrinsic state** from **context-specific extrinsic state**.

**Problem:** Duplicating many objects with partially identical data consumes excessive memory.

**Key Terms:**
- **Intrinsic State:** Shared, immutable data
- **Extrinsic State:** Context-specific data unique to each instance
- **Flyweight Factory:** Manages and reuses shared instances

```dart
// DART EXAMPLE

class CharacterStyle {
  final String font;
  final int size;
  CharacterStyle(this.font, this.size);
}

class StyleFactory {
  final Map<String, CharacterStyle> _cache = {};

  CharacterStyle getStyle(String font, int size) {
    final key = '$font-$size';
    return _cache.putIfAbsent(key, () => CharacterStyle(font, size));
  }
}


void main() {
  // --- Usage ---
  final factory = StyleFactory();
  final s1 = factory.getStyle('Arial', 12);
  final s2 = factory.getStyle('Arial', 12);
  print(identical(s1, s2)); // true — same object in memory
}
```
> 📄 [View source code](lib/flyweight.dart)

**When to use?** When you have thousands of objects sharing similar data.

---

## 12. Proxy

**Description:** Provides a surrogate or placeholder for another object to control access to it. Acts as a gatekeeper that can add logic before or after accessing the real object.

**Problem:** You need to control how and when an expensive or sensitive object is accessed.

**Key Terms:**
- **Real Subject:** The original object
- **Virtual Proxy:** Delays object creation until needed
- **Protection Proxy:** Controls access permissions

```dart
// DART EXAMPLE

abstract class Database {
  String query(String sql);
}

class RealDatabase implements Database {
  RealDatabase() {
    print('⏳ Connecting to database...');
  }
  @override
  String query(String sql) => 'Results: $sql';
}

class DatabaseProxy implements Database {
  RealDatabase? _db;

  @override
  String query(String sql) {
    // Lazy initialization — connects on first query only
    _db ??= RealDatabase();
    print('📋 Logging query: $sql');
    return _db!.query(sql);
  }
}


void main() {
  // --- Usage ---
  final db = DatabaseProxy(); // Not connected yet
  print(db.query('SELECT * FROM users')); // Connects now, then logs and executes
}
```
> 📄 [View source code](lib/proxy.dart)

**When to use?** For lazy loading, caching, or access control scenarios.

---

# Part III: Behavioral Patterns

> **How do objects communicate and distribute responsibilities among themselves?**
>
> These patterns focus on algorithms and the assignment of responsibilities between objects in a flexible, extensible way.

---

## 13. Chain of Responsibility

**Description:** Passes a request along a chain of handlers. Each handler either processes the request or forwards it to the next handler in the chain.

**Key Terms:**
- **Handler:** The shared interface for all handlers
- **Successor:** The next handler in the chain

```dart
// DART EXAMPLE

abstract class SupportHandler {
  SupportHandler? _next;

  SupportHandler setNext(SupportHandler handler) {
    _next = handler;
    return handler;
  }

  String handle(String issue) {
    if (_next != null) return _next!.handle(issue);
    return '❌ Unresolved issue: $issue';
  }
}

class BotSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'password_reset') return '🤖 Password reset link sent';
    return super.handle(issue);
  }
}

class HumanSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'billing') return '👨‍💼 Transferring to billing department';
    return super.handle(issue);
  }
}


void main() {
  // --- Usage ---
  final bot = BotSupport();
  bot.setNext(HumanSupport());

  print(bot.handle('password_reset')); // 🤖 Password reset link sent
  print(bot.handle('billing'));        // 👨‍💼 Transferring to billing department
  print(bot.handle('unknown'));        // ❌ Unresolved issue: unknown
}
```
> 📄 [View source code](lib/chain_of_responsibility.dart)

---

## 14. Command

**Description:** Encapsulates a request as a **standalone object** containing all request information. Enables deferred execution, undo/redo, and operation logging.

**Key Terms:**
- **Receiver:** The object that performs the actual work
- **Invoker:** The object that triggers the command
- **Concrete Command:** The specific implementation linking invoker to receiver

```dart
// DART EXAMPLE

abstract class Command {
  void execute();
  void undo();
}

class TextEditor {
  String content = '';
  void append(String text) => content += text;
  void removeLast(int count) =>
      content = content.substring(0, content.length - count);
}

class TypeCommand implements Command {
  final TextEditor _editor;
  final String _text;
  TypeCommand(this._editor, this._text);

  @override
  void execute() => _editor.append(_text);

  @override
  void undo() => _editor.removeLast(_text.length);
}


void main() {
  // --- Usage ---
  final editor = TextEditor();
  final commands = <Command>[];

  final cmd1 = TypeCommand(editor, 'Hello ');
  final cmd2 = TypeCommand(editor, 'World!');

  cmd1.execute();
  cmd2.execute();
  commands.addAll([cmd1, cmd2]);
  print(editor.content); // Hello World!

  commands.removeLast().undo();
  print(editor.content); // Hello
}
```
> 📄 [View source code](lib/command.dart)

---

## 15. Interpreter

**Description:** Defines a representation for a language's grammar and an interpreter that uses this representation to interpret sentences in that language.

**Key Terms:**
- **Context:** Shared information during interpretation
- **Terminal Expression:** A basic element in the grammar
- **Non-terminal Expression:** A composite rule

```dart
// DART EXAMPLE

abstract class Expression {
  int interpret(Map<String, int> context);
}

class NumberExp implements Expression {
  final String variable;
  NumberExp(this.variable);

  @override
  int interpret(Map<String, int> context) => context[variable] ?? 0;
}

class AddExp implements Expression {
  final Expression left, right;
  AddExp(this.left, this.right);

  @override
  int interpret(Map<String, int> context) =>
      left.interpret(context) + right.interpret(context);
}


void main() {
  // --- Usage: x + y ---
  final expression = AddExp(NumberExp('x'), NumberExp('y'));
  print(expression.interpret({'x': 10, 'y': 20})); // 30
}
```
> 📄 [View source code](lib/interpreter.dart)

---

## 16. Iterator

**Description:** Provides a way to sequentially access elements of a collection without exposing its underlying structure.

**Key Terms:**
- **Aggregate:** The collection containing the elements
- **Concrete Iterator:** The implementation that tracks traversal position

```dart
// DART EXAMPLE

class Song {
  final String title;
  final String artist;
  Song(this.title, this.artist);

  @override
  String toString() => '$title — $artist';
}

class PlaylistIterator implements Iterator<Song> {
  final List<Song> _songs;
  int _index = -1;

  PlaylistIterator(this._songs);

  @override
  Song get current => _songs[_index];

  @override
  bool moveNext() {
    _index++;
    return _index < _songs.length;
  }
}

class Playlist {
  final String name;
  final List<Song> _songs = [];

  Playlist(this.name);

  void add(Song song) => _songs.add(song);
  int get length => _songs.length;

  PlaylistIterator get iterator => PlaylistIterator(_songs);
}

void main() {
  // --- Usage ---
  final playlist = Playlist('My Favorites')
    ..add(Song('Bohemian Rhapsody', 'Queen'))
    ..add(Song('Stairway to Heaven', 'Led Zeppelin'))
    ..add(Song('Hotel California', 'Eagles'));

  print('🎵 ${playlist.name} (${playlist.length} songs):');

  final it = playlist.iterator;
  while (it.moveNext()) {
    print('  ▶ ${it.current}');
  }
  // 🎵 My Favorites (3 songs):
  //   ▶ Bohemian Rhapsody — Queen
  //   ▶ Stairway to Heaven — Led Zeppelin
  //   ▶ Hotel California — Eagles
}
```
> 📄 [View source code](lib/iterator_pattern.dart)

---

## 17. Mediator

**Description:** Reduces direct coupling between objects by making them communicate through a **mediator** object instead of directly.

**Key Terms:**
- **Colleague:** The objects that communicate via the mediator
- **Concrete Mediator:** The implementation that coordinates communication

```dart
// DART EXAMPLE

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
```
> 📄 [View source code](lib/mediator.dart)

---

## 18. Memento

**Description:** Captures an object's internal state in a snapshot so it can be restored later without violating encapsulation.

**Key Terms:**
- **Originator:** The object that creates and restores from snapshots
- **Caretaker:** Manages and stores snapshots

```dart
// DART EXAMPLE

class EditorMemento {
  final String content;
  EditorMemento(this.content);
}

class Editor {
  String content = '';

  EditorMemento save() => EditorMemento(content);
  void restore(EditorMemento memento) => content = memento.content;
}

// --- Caretaker ---
class History {
  final _snapshots = <EditorMemento>[];

  void push(EditorMemento memento) => _snapshots.add(memento);
  EditorMemento? pop() => _snapshots.isNotEmpty ? _snapshots.removeLast() : null;
}


void main() {
  // --- Usage ---
  final editor = Editor();
  final history = History();

  editor.content = 'Chapter 1';
  history.push(editor.save());

  editor.content = 'Chapter 2';
  history.push(editor.save());

  editor.content = 'Wrong text!';

  editor.restore(history.pop()!);
  print(editor.content); // Chapter 2
}
```
> 📄 [View source code](lib/memento.dart)

---

## 19. Observer

**Description:** Defines a **one-to-many** dependency between objects, so when one object changes state, all its dependents are notified automatically.

**Key Terms:**
- **Subject:** The observed object holding the state
- **Observer:** The object receiving notifications
- **Notify:** The operation of informing observers about changes

```dart
// DART EXAMPLE

class EventEmitter<T> {
  final _listeners = <void Function(T)>[];

  void on(void Function(T) listener) => _listeners.add(listener);
  void off(void Function(T) listener) => _listeners.remove(listener);
  void emit(T event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }
}


void main() {
  // --- Usage ---
  final priceTracker = EventEmitter<double>();

  priceTracker.on((price) => print('📊 New price: $price'));
  priceTracker.on((price) {
    if (price < 50) print('🔔 Alert: Price is low!');
  });

  priceTracker.emit(75.0); // 📊 New price: 75.0
  priceTracker.emit(45.0); // 📊 New price: 45.0  +  🔔 Alert: Price is low!
}
```
> 📄 [View source code](lib/observer.dart)

---

## 20. State

**Description:** Allows an object to change its behavior when its internal state changes. The object appears to change its class.

**Key Terms:**
- **Context:** The object whose state changes
- **Concrete State:** A specific behavior implementation for a state

```dart
// DART EXAMPLE

abstract class OrderState {
  void next(Order order);
  String get status;
}

class PendingState implements OrderState {
  @override
  void next(Order order) => order.state = ProcessingState();
  @override
  String get status => 'Pending';
}

class ProcessingState implements OrderState {
  @override
  void next(Order order) => order.state = DeliveredState();
  @override
  String get status => 'Processing';
}

class DeliveredState implements OrderState {
  @override
  void next(Order order) => print('Order already completed!');
  @override
  String get status => 'Delivered';
}

class Order {
  OrderState state = PendingState();
  void proceed() => state.next(this);
}


void main() {
  // --- Usage ---
  final order = Order();
  print(order.state.status); // Pending
  order.proceed();
  print(order.state.status); // Processing
  order.proceed();
  print(order.state.status); // Delivered
}
```
> 📄 [View source code](lib/state.dart)

---

## 21. Strategy

**Description:** Defines a family of algorithms, encapsulates each one, and makes them interchangeable. Allows changing the algorithm at runtime.

**Key Terms:**
- **Context:** The object using the strategy
- **Concrete Strategy:** A specific algorithm implementation

```dart
// DART EXAMPLE

typedef SortStrategy = List<int> Function(List<int> data);

List<int> bubbleSort(List<int> data) {
  final list = List.of(data);
  for (var i = 0; i < list.length; i++) {
    for (var j = 0; j < list.length - i - 1; j++) {
      if (list[j] > list[j + 1]) {
        final temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
  return list;
}

List<int> quickSort(List<int> data) => (List.of(data)..sort());

class Sorter {
  SortStrategy strategy;
  Sorter(this.strategy);

  List<int> sort(List<int> data) => strategy(data);
}


void main() {
  // --- Usage ---
  final sorter = Sorter(bubbleSort);
  print(sorter.sort([3, 1, 2])); // [1, 2, 3]

  sorter.strategy = quickSort; // Swap strategy at runtime
  print(sorter.sort([9, 5, 7])); // [5, 7, 9]
}
```
> 📄 [View source code](lib/strategy.dart)

---

## 22. Template Method

**Description:** Defines the **skeleton** of an algorithm in a base class, and lets subclasses override specific steps without changing the overall structure.

**Key Terms:**
- **Hook Method:** An optional method subclasses may override
- **Primitive Operation:** A mandatory step subclasses must implement

```dart
// DART EXAMPLE

abstract class DataExporter {
  // Template Method — the fixed skeleton
  void export() {
    final data = fetchData();
    final formatted = format(data);
    save(formatted);
  }

  List<String> fetchData();          // Primitive operation
  String format(List<String> data);  // Primitive operation
  void save(String output) => print('💾 Saved: $output'); // Hook
}

class CsvExporter extends DataExporter {
  @override
  List<String> fetchData() => ['name', 'age', 'city'];

  @override
  String format(List<String> data) => data.join(',');
}

class JsonExporter extends DataExporter {
  @override
  List<String> fetchData() => ['name', 'age', 'city'];

  @override
  String format(List<String> data) =>
      '{"fields": [${data.map((e) => '"$e"').join(', ')}]}';
}


void main() {
  // --- Usage ---
  CsvExporter().export();  // 💾 Saved: name,age,city
  JsonExporter().export(); // 💾 Saved: {"fields": ["name", "age", "city"]}
}
```
> 📄 [View source code](lib/template_method.dart)

---

## 23. Visitor

**Description:** Separates **operations** from the **object structure** they operate on. Allows adding new operations without modifying the element classes.

**Key Terms:**
- **Element:** The object that accepts a visitor
- **Concrete Visitor:** The implementation containing logic for each element type
- **Accept Method:** The method an element calls to receive a visitor

```dart
// DART EXAMPLE

abstract class Shape {
  void accept(ShapeVisitor visitor);
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);

  @override
  void accept(ShapeVisitor visitor) => visitor.visitCircle(this);
}

class Rectangle implements Shape {
  final double width, height;
  Rectangle(this.width, this.height);

  @override
  void accept(ShapeVisitor visitor) => visitor.visitRectangle(this);
}

abstract class ShapeVisitor {
  void visitCircle(Circle circle);
  void visitRectangle(Rectangle rectangle);
}

class AreaCalculator implements ShapeVisitor {
  @override
  void visitCircle(Circle c) =>
      print('Circle area: ${3.14159 * c.radius * c.radius}');

  @override
  void visitRectangle(Rectangle r) =>
      print('Rectangle area: ${r.width * r.height}');
}


void main() {
  // --- Usage ---
  final shapes = <Shape>[Circle(5), Rectangle(4, 6)];
  final calculator = AreaCalculator();

  for (final shape in shapes) {
    shape.accept(calculator);
  }
  // Circle area: 78.53975
  // Rectangle area: 24.0
}
```
> 📄 [View source code](lib/visitor.dart)

---

# 📊 Summary Table

| Category | Count |
| :--- | :---: |
| Creational | 5 |
| Structural | 7 |
| Behavioral | 11 |
| **Total** | **23** |

---

# 🧠 Quick Mental Model

| Category | Core Question | Most Common Examples |
| :--- | :--- | :--- |
| **Creational** | How do we create objects? | Singleton, Factory |
| **Structural** | How do we compose objects? | Adapter, Decorator |
| **Behavioral** | How do objects communicate? | Observer, Strategy |
