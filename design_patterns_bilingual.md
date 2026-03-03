# 🎯 أنماط التصميم | Design Patterns

**الأنماط الثلاثة والعشرون (GoF) — شرح مُفصَّل بأمثلة Dart**
**The 23 Gang of Four Patterns — Detailed Explanation with Dart Examples**

> أنماط التصميم هي حلول مُجرَّبة لمشكلات شائعة في تصميم البرمجيات. لا تُمثِّل كودًا جاهزًا، بل هي **قوالب فكرية** يمكن تطبيقها على مواقف مختلفة.
>
> Design patterns are proven, reusable solutions to common problems in software design. They are not ready-made code, but rather **conceptual templates** that can be applied to various situations.

> 💡 الأمثلة هنا مُبسَّطة للشرح. ملفات `lib/` تتبع [Effective Dart](https://dart.dev/effective-dart) بالكامل (`final class`, `interface class`, `const` constructors, `///` doc comments).
>
> 💡 Examples here are simplified for learning. The `lib/` files follow full [Effective Dart](https://dart.dev/effective-dart) guidelines (`final class`, `interface class`, `const` constructors, `///` doc comments).

---

# أولًا: الأنماط الإنشائية | Part I: Creational Patterns

> **كيف نُنشئ الكائنات بطريقة مرنة وقابلة للتوسُّع؟**
>
> **How do we create objects in a flexible and extensible way?**

---

<a id="abstract-factory"></a>

## 1. المصنع المُجرَّد | Abstract Factory

**الوصف:** يُوفِّر واجهة (Interface) لإنشاء **عائلة من الكائنات المترابطة** دون تحديد أصنافها الفعلية. يضمن أن المنتجات المُنشأة تتوافق مع بعضها.

**Description:** Provides an interface for creating **families of related objects** without specifying their concrete classes. Ensures that created products are compatible with each other.

**المشكلة:** تحتاج إنشاء مجموعة كائنات مترابطة دون ربط الكود بأنواع محددة.

**Problem:** You need to create a set of related objects without coupling the code to concrete types.

| المصطلح بالعربية | English Term |
|---|---|
| المصنع المُجرَّد | Abstract Factory |
| المصنع الفعلي | Concrete Factory |
| المُنتَج المُجرَّد | Abstract Product |
| عائلة المُنتَجات | Product Family |

```dart
// DART EXAMPLE

// --- المُنتَجات المُجرَّدة ---
// --- Abstract Products ---
abstract class Button {
  String render();
}

abstract class TextField {
  String render();
}

// --- المُنتَجات الفعلية ---
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

// --- المصنع المُجرَّد ---
// --- Abstract Factory ---
abstract class WidgetFactory {
  Button createButton();
  TextField createTextField();
}

// --- المصانع الفعلية ---
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
> 📄 [الكود المصدري | View source code](lib/abstract_factory.dart)

> **متى تستخدمه؟** عندما يحتاج تطبيقك دعم منصات أو سمات (Themes) مختلفة بعناصر واجهة متناسقة.
>
> **When to use?** When your app needs to support multiple platforms or themes with consistent UI components.

---

<a id="builder"></a>

## 2. الباني | Builder

**الوصف:** يفصل بناء كائن مُعقَّد عن تمثيله، بحيث تبني الكائن **خطوة بخطوة** بدلًا من مُنشئ (Constructor) ضخم مليء بالمُعامِلات.

**Description:** Separates the construction of a complex object from its representation, allowing you to build the object **step by step** instead of a massive constructor.

**المشكلة:** مُنشئ يحتوي عشرات المُعامِلات الاختيارية، مما يجعل الكود صعب القراءة.

**Problem:** A constructor with dozens of optional parameters, making the code hard to read and maintain.

| المصطلح بالعربية | English Term |
|---|---|
| الباني | Builder |
| الباني الفعلي | Concrete Builder |
| المُوجِّه | Director |
| المُنتَج | Product |

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

  // تحديد الحجم | Set size
  PizzaBuilder setSize(String size) {
    _pizza.size = size;
    return this; // لتمكين سلسلة الاستدعاءات | Enables method chaining
  }

  // تحديد العجينة | Set crust
  PizzaBuilder setCrust(String crust) {
    _pizza.crust = crust;
    return this;
  }

  // إضافة طبقة | Add topping
  PizzaBuilder addTopping(String topping) {
    _pizza.toppings.add(topping);
    return this;
  }

  // بناء المُنتَج النهائي | Build final product
  Pizza build() => _pizza;
}


void main() {
  // --- الاستخدام ---
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
> 📄 [الكود المصدري | View source code](lib/builder.dart)

> **متى تستخدمه؟** عندما يكون لديك كائن يحتوي خيارات بناء كثيرة ومتنوعة.
>
> **When to use?** When you have an object with many diverse construction options.

---

<a id="factory-method"></a>

## 3. دالّة المصنع | Factory Method

**الوصف:** يُحدِّد واجهة لإنشاء كائن، لكنه يترك قرار **أي صنف يتم إنشاؤه** للأصناف الفرعية (Subclasses).

**Description:** Defines an interface for creating an object, but lets **subclasses decide which class to instantiate**.

**المشكلة:** تريد فصل منطق الإنشاء عن كود الاستخدام لتسهيل إضافة أنواع جديدة.

**Problem:** You want to decouple creation logic from usage code, making it easy to add new types.

| المصطلح بالعربية | English Term |
|---|---|
| المُنشئ | Creator |
| المُنشئ الفعلي | Concrete Creator |
| المُنتَج | Product |

```dart
// DART EXAMPLE

// --- واجهة المُنتَج ---
// --- Product Interface ---
abstract class Notification {
  void send(String message);
}

// --- المُنتَجات الفعلية ---
// --- Concrete Products ---
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

// --- دالّة المصنع ---
// --- Factory Method ---
Notification createNotification(String type) {
  return switch (type) {
    'email' => EmailNotification(),
    'sms'   => SmsNotification(),
    'push'  => PushNotification(),
    _       => throw ArgumentError('نوع غير معروف | Unknown type: $type'),
  };
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final notification = createNotification('email');
  notification.send('مرحبًا! | Hello!'); // Email: مرحبًا! | Hello!
}
```
> 📄 [الكود المصدري | View source code](lib/factory_method.dart)

> **متى تستخدمه؟** عندما لا تعرف مُسبقًا النوع الدقيق للكائنات التي سيُنشئها الكود.
>
> **When to use?** When you don't know in advance the exact type of objects your code will create.

---

<a id="prototype"></a>

## 4. النموذج الأوَّلي | Prototype

**الوصف:** يُنشئ كائنات جديدة عن طريق **نسخ** (Cloning) كائن موجود بدلًا من بنائه من الصفر.

**Description:** Creates new objects by **cloning** existing ones instead of building from scratch.

**المشكلة:** إنشاء الكائن مُكلِّف وتحتاج نُسخًا عديدة بإعدادات مشابهة.

**Problem:** Object creation is costly and you need many instances with similar configurations.

| المصطلح بالعربية | English Term |
|---|---|
| النسخ | Cloning |
| النسخ العميق | Deep Copy |
| النسخ السطحي | Shallow Copy |

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

  // نسخ عميق — نسخ القائمة لا مشاركتها
  // Deep Copy — copy the list, don't share it
  GameConfig clone() {
    return GameConfig(
      difficulty: difficulty,
      maxPlayers: maxPlayers,
      enabledModes: List.from(enabledModes),
    );
  }
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final defaultConfig = GameConfig(
    difficulty: 'Normal',
    maxPlayers: 4,
    enabledModes: ['Survival', 'Creative'],
  );

  final customConfig = defaultConfig.clone()
    ..difficulty = 'Hard'
    ..enabledModes.add('Adventure');

  print(defaultConfig.enabledModes); // [Survival, Creative] — لم تتأثر | unaffected
  print(customConfig.enabledModes);  // [Survival, Creative, Adventure]
}
```
> 📄 [الكود المصدري | View source code](lib/prototype.dart)

> **متى تستخدمه؟** عندما تريد إنشاء كائنات مُشابهة بتكلفة أقل من البناء الكامل.
>
> **When to use?** When you want to create similar objects at a lower cost than full construction.

---

<a id="singleton"></a>

## 5. الكائن الوحيد | Singleton

**الوصف:** يضمن أن الصنف لديه **نسخة واحدة فقط** طوال عمر التطبيق، ويُوفِّر نقطة وصول عامة لها.

**Description:** Ensures a class has **only one instance** throughout the application's lifetime and provides a global access point to it.

**المشكلة:** تحتاج نسخة واحدة مُشتركة من خدمة ما ولا يجب إنشاء أكثر من نسخة.

**Problem:** You need a single shared instance, and creating more than one would cause issues.

| المصطلح بالعربية | English Term |
|---|---|
| نقطة الوصول العامة | Global Access Point |
| التهيئة الكسولة | Lazy Initialization |
| التهيئة الفورية | Eager Initialization |

```dart
// DART EXAMPLE

class AppConfig {
  // Dart يضمن التهيئة مرة واحدة
  // Dart guarantees static final fields are initialized once
  static final AppConfig _instance = AppConfig._internal();

  String appName = 'MyApp';
  bool debugMode = false;

  // مُنشئ خاص — لا يمكن إنشاء نُسخ من خارج الصنف
  // Private constructor — no external instantiation
  AppConfig._internal();

  // مُنشئ المصنع يُرجع النسخة الوحيدة دائمًا
  // Factory constructor always returns the same instance
  factory AppConfig() => _instance;
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final config1 = AppConfig();
  final config2 = AppConfig();
  config1.debugMode = true;

  print(identical(config1, config2)); // true — نفس النسخة | same instance
  print(config2.debugMode);           // true — التغيير ظهر | change reflected
}
```
> 📄 [الكود المصدري | View source code](lib/singleton.dart)

> **متى تستخدمه؟** عندما تحتاج نسخة واحدة مُشتركة يصل إليها التطبيق بالكامل.
>
> **When to use?** When you need one shared instance accessible by the entire application.

---

# ثانيًا: الأنماط البنائية | Part II: Structural Patterns

> **كيف نُركِّب الكائنات معًا بشكل مرن وفعَّال؟**
>
> **How do we compose objects into larger, flexible structures?**

---

<a id="adapter"></a>

## 6. المُحوِّل | Adapter

**الوصف:** يُحوِّل واجهة صنف إلى واجهة أخرى يتوقعها العميل. يعمل كـ**جسر توافق** بين واجهتين غير متوافقتين.

**Description:** Converts one class's interface into another expected by the client. Acts as a **compatibility bridge** between two incompatible interfaces.

| المصطلح بالعربية | English Term |
|---|---|
| الهدف | Target |
| المُتكيِّف معه | Adaptee |
| المُغلِّف | Wrapper |

```dart
// DART EXAMPLE

// --- الواجهة المتوقعة ---
// --- Target Interface ---
abstract class JsonLogger {
  void logJson(Map<String, dynamic> data);
}

// --- صنف قديم غير متوافق ---
// --- Incompatible Legacy Class ---
class LegacyFileLogger {
  void writeToFile(String text) => print('LOG FILE: $text');
}

// --- المُحوِّل ---
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
  // --- الاستخدام ---
  // --- Usage ---
  final JsonLogger logger = FileLoggerAdapter(LegacyFileLogger());
  logger.logJson({'event': 'login', 'user': 'ahmad'});
  // LOG FILE: event=login, user=ahmad
}
```
> 📄 [الكود المصدري | View source code](lib/adapter.dart)

> **متى تستخدمه؟** عند دمج مكتبة قديمة أو خارجية مع كودك الحالي.
>
> **When to use?** When integrating legacy or third-party libraries with your current codebase.

---

<a id="bridge"></a>

## 7. الجسر | Bridge

**الوصف:** يفصل **التجريد** عن **التنفيذ** بحيث يتغيَّر كلٌّ منهما بشكل مستقل. يستخدم التركيب (Composition) بدلًا من الوراثة.

**Description:** Decouples an **abstraction** from its **implementation** so both can vary independently. Uses composition instead of inheritance.

| المصطلح بالعربية | English Term |
|---|---|
| التجريد | Abstraction |
| المُنفِّذ | Implementor |
| التجريد المُنقَّح | Refined Abstraction |

```dart
// DART EXAMPLE

// --- التنفيذ ---
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

// --- التجريد ---
// --- Abstraction ---
class NotificationManager {
  final MessageSender _sender;
  NotificationManager(this._sender);

  void notify(String message) => _sender.sendMessage(message);
}

// --- التجريد المُنقَّح ---
// --- Refined Abstraction ---
class UrgentNotification extends NotificationManager {
  UrgentNotification(super.sender);

  @override
  void notify(String message) => super.notify('🚨 عاجل | URGENT: $message');
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final urgentSms = UrgentNotification(SmsSender());
  urgentSms.notify('الخادم توقف! | Server down!');
  // SMS: 🚨 عاجل | URGENT: الخادم توقف! | Server down!
}
```
> 📄 [الكود المصدري | View source code](lib/bridge.dart)

> **متى تستخدمه؟** عندما يكون لديك بُعدان مستقلان من التنوُّع وتريد تجنُّب انفجار عدد الأصناف.
>
> **When to use?** When you have two independent dimensions of variation and want to avoid class explosion.

---

<a id="composite"></a>

## 8. المُركَّب | Composite

**الوصف:** يُتيح التعامل مع **الكائنات المُفردة والمجموعات** بنفس الطريقة عبر بنية شجرية (Tree Structure).

**Description:** Lets you treat **individual objects and groups** uniformly through a tree structure.

| المصطلح بالعربية | English Term |
|---|---|
| المُكوِّن | Component |
| الورقة | Leaf |
| المُركَّب | Composite |

```dart
// DART EXAMPLE

// --- الواجهة المشتركة ---
// --- Shared Interface ---
abstract class FileSystemEntity {
  String get name;
  int getSize();
}

// --- الورقة ---
// --- Leaf ---
class File implements FileSystemEntity {
  @override
  final String name;
  final int size;
  File(this.name, this.size);

  @override
  int getSize() => size;
}

// --- المُركَّب ---
// --- Composite ---
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
  // --- الاستخدام ---
  // --- Usage ---
  final root = Folder('root')
    ..add(File('readme.md', 100))
    ..add(Folder('src')
      ..add(File('main.dart', 500))
      ..add(File('utils.dart', 300)));

  print(root.getSize()); // 900
}
```
> 📄 [الكود المصدري | View source code](lib/composite.dart)

> **متى تستخدمه؟** عند التعامل مع بنى شجرية (ملفات، قوائم، واجهات رسومية).
>
> **When to use?** When dealing with tree structures (files, menus, UI widgets).

---

<a id="decorator"></a>

## 9. المُزخرِف | Decorator

**الوصف:** يُضيف مسؤوليات جديدة لكائن **ديناميكيًا** دون تعديل صنفه أو اللجوء لوراثة مُتعدِّدة.

**Description:** Attaches additional responsibilities to an object **dynamically** without modifying its class or resorting to excessive inheritance.

| المصطلح بالعربية | English Term |
|---|---|
| المُغلِّف | Wrapper |
| المُزخرِف الفعلي | Concrete Decorator |

```dart
// DART EXAMPLE

// --- الواجهة الأساسية ---
// --- Base Interface ---
abstract class Coffee {
  String get description;
  double get cost;
}

class SimpleCoffee implements Coffee {
  @override
  String get description => 'قهوة بسيطة | Simple Coffee';
  @override
  double get cost => 5.0;
}

// --- مُزخرِفات ---
// --- Decorators ---
class MilkDecorator implements Coffee {
  final Coffee _coffee;
  MilkDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + حليب | Milk';
  @override
  double get cost => _coffee.cost + 1.5;
}

class SugarDecorator implements Coffee {
  final Coffee _coffee;
  SugarDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + سكر | Sugar';
  @override
  double get cost => _coffee.cost + 0.5;
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  Coffee order = SimpleCoffee();
  order = MilkDecorator(order);
  order = SugarDecorator(order);

  print(order.description); // قهوة بسيطة | Simple Coffee + حليب | Milk + سكر | Sugar
  print(order.cost);        // 7.0
}
```
> 📄 [الكود المصدري | View source code](lib/decorator.dart)

> **متى تستخدمه؟** عند الحاجة لإضافة سلوكيات اختيارية ومُركَّبة ديناميكيًا.
>
> **When to use?** When you need to add optional, composable behaviors dynamically.

---

<a id="facade"></a>

## 10. الواجهة المُبسَّطة | Facade

**الوصف:** يُوفِّر واجهة مُبسَّطة وموحَّدة لنظام فرعي مُعقَّد. يُخفي التعقيد الداخلي.

**Description:** Provides a simplified, unified interface to a complex subsystem. Hides internal complexity.

| المصطلح بالعربية | English Term |
|---|---|
| النظام الفرعي | Subsystem |
| الواجهة الموحَّدة | Unified Interface |

```dart
// DART EXAMPLE

// --- أصناف النظام الفرعي المُعقَّد ---
// --- Complex Subsystem Classes ---
class AudioDecoder {
  String decode(String file) => 'audio_data($file)';
}

class VideoDecoder {
  String decode(String file) => 'video_data($file)';
}

class ScreenRenderer {
  void render(String video, String audio) =>
      print('▶ عرض | Playing: $video + $audio');
}

// --- الواجهة المُبسَّطة ---
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
  // --- الاستخدام ---
  // --- Usage ---
  MediaPlayer().play('movie.mp4');
  // ▶ عرض | Playing: video_data(movie.mp4) + audio_data(movie.mp4)
}
```
> 📄 [الكود المصدري | View source code](lib/facade.dart)

> **متى تستخدمه؟** عندما تريد تبسيط التخاطب مع نظام فرعي مُعقَّد.
>
> **When to use?** When you want to simplify interaction with a complex subsystem.

---

<a id="flyweight"></a>

## 11. وزن الذبابة | Flyweight

**الوصف:** يُقلِّل استهلاك الذاكرة بمشاركة البيانات المُشتركة بين الكائنات المتشابهة.

**Description:** Reduces memory consumption by sharing data among similar objects.

| المصطلح بالعربية | English Term |
|---|---|
| الحالة الداخلية | Intrinsic State |
| الحالة الخارجية | Extrinsic State |
| مصنع وزن الذبابة | Flyweight Factory |

```dart
// DART EXAMPLE

class CharacterStyle {
  final String font;
  final int size;
  CharacterStyle(this.font, this.size);
}

// --- المصنع — يُعيد استخدام النُّسخ المُشتركة ---
// --- Factory — reuses shared instances ---
class StyleFactory {
  final Map<String, CharacterStyle> _cache = {};

  CharacterStyle getStyle(String font, int size) {
    final key = '$font-$size';
    return _cache.putIfAbsent(key, () => CharacterStyle(font, size));
  }
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final factory = StyleFactory();
  final s1 = factory.getStyle('Arial', 12);
  final s2 = factory.getStyle('Arial', 12);
  print(identical(s1, s2)); // true — نفس الكائن في الذاكرة | same object in memory
}
```
> 📄 [الكود المصدري | View source code](lib/flyweight.dart)

> **متى تستخدمه؟** عند وجود آلاف الكائنات التي تتشارك بيانات مُتشابهة.
>
> **When to use?** When you have thousands of objects sharing similar data.

---

<a id="proxy"></a>

## 12. الوكيل | Proxy

**الوصف:** يُوفِّر بديلًا عن كائن آخر للتحكُّم في الوصول إليه. يعمل كحارس بوابة.

**Description:** Provides a surrogate for another object to control access to it. Acts as a gatekeeper.

| المصطلح بالعربية | English Term |
|---|---|
| الموضوع الحقيقي | Real Subject |
| الوكيل الافتراضي | Virtual Proxy |
| وكيل الحماية | Protection Proxy |

```dart
// DART EXAMPLE

abstract class Database {
  String query(String sql);
}

class RealDatabase implements Database {
  RealDatabase() {
    print('⏳ جاري الاتصال... | Connecting...');
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
    print('📋 تسجيل | Logging: $sql');
    return _db!.query(sql);
  }
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final db = DatabaseProxy(); // لم يتصل بعد | Not connected yet
  print(db.query('SELECT * FROM users'));
}
```
> 📄 [الكود المصدري | View source code](lib/proxy.dart)

> **متى تستخدمه؟** عند الحاجة للتحميل الكسول، التخزين المؤقت، أو التحكُّم في الصلاحيات.
>
> **When to use?** For lazy loading, caching, or access control scenarios.

---

# ثالثًا: الأنماط السلوكية | Part III: Behavioral Patterns

> **كيف تتواصل الكائنات وتتوزَّع المسؤوليات؟**
>
> **How do objects communicate and distribute responsibilities?**

---

<a id="chain-of-responsibility"></a>

## 13. سلسلة المسؤولية | Chain of Responsibility

**الوصف:** يُمرِّر الطلب عبر سلسلة من المُعالِجات. كل مُعالِج إما يُعالجه أو يُمرِّره للتالي.

**Description:** Passes a request along a chain of handlers. Each handler either processes it or forwards it.

| المصطلح بالعربية | English Term |
|---|---|
| المُعالِج | Handler |
| الخَلَف | Successor |

```dart
// DART EXAMPLE

abstract class SupportHandler {
  SupportHandler? _next;

  // تحديد المُعالِج التالي
  // Set the next handler
  SupportHandler setNext(SupportHandler handler) {
    _next = handler;
    return handler;
  }

  String handle(String issue) {
    if (_next != null) return _next!.handle(issue);
    return '❌ لم يتم الحل | Unresolved: $issue';
  }
}

class BotSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'password_reset') return '🤖 تم إرسال الرابط | Link sent';
    return super.handle(issue);
  }
}

class HumanSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'billing') return '👨‍💼 تحويل للفوترة | Transferring to billing';
    return super.handle(issue);
  }
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final bot = BotSupport();
  bot.setNext(HumanSupport());

  print(bot.handle('password_reset')); // 🤖 تم إرسال الرابط | Link sent
  print(bot.handle('billing'));        // 👨‍💼 تحويل للفوترة | Transferring to billing
  print(bot.handle('unknown'));        // ❌ لم يتم الحل | Unresolved: unknown
}
```
> 📄 [الكود المصدري | View source code](lib/chain_of_responsibility.dart)

---

<a id="command"></a>

## 14. الأمر | Command

**الوصف:** يُحوِّل الطلب إلى **كائن مستقل** يُتيح التأجيل، التراجع (Undo)، والتسجيل.

**Description:** Encapsulates a request as a **standalone object**, enabling deferred execution, undo/redo, and logging.

| المصطلح بالعربية | English Term |
|---|---|
| المُستقبِل | Receiver |
| المُستدعي | Invoker |
| الأمر الفعلي | Concrete Command |

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
  // --- الاستخدام ---
  // --- Usage ---
  final editor = TextEditor();
  final commands = <Command>[];

  final cmd1 = TypeCommand(editor, 'Hello ');
  final cmd2 = TypeCommand(editor, 'World!');

  cmd1.execute();
  cmd2.execute();
  commands.addAll([cmd1, cmd2]);
  print(editor.content); // Hello World!

  // التراجع | Undo
  commands.removeLast().undo();
  print(editor.content); // Hello
}
```
> 📄 [الكود المصدري | View source code](lib/command.dart)

---

<a id="interpreter"></a>

## 15. المُفسِّر | Interpreter

**الوصف:** يُعرِّف تمثيلًا لقواعد لغة (Grammar) ومُفسِّرًا لتفسير جُملها.

**Description:** Defines a representation for a language's grammar and an interpreter to interpret its sentences.

| المصطلح بالعربية | English Term |
|---|---|
| السياق | Context |
| التعبير النهائي | Terminal Expression |
| التعبير غير النهائي | Non-terminal Expression |

```dart
// DART EXAMPLE

abstract class Expression {
  int interpret(Map<String, int> context);
}

// --- تعبير نهائي — متغيِّر ---
// --- Terminal — variable ---
class NumberExp implements Expression {
  final String variable;
  NumberExp(this.variable);

  @override
  int interpret(Map<String, int> context) => context[variable] ?? 0;
}

// --- تعبير غير نهائي — جمع ---
// --- Non-terminal — addition ---
class AddExp implements Expression {
  final Expression left, right;
  AddExp(this.left, this.right);

  @override
  int interpret(Map<String, int> context) =>
      left.interpret(context) + right.interpret(context);
}


void main() {
  // --- الاستخدام: x + y ---
  // --- Usage: x + y ---
  final expression = AddExp(NumberExp('x'), NumberExp('y'));
  print(expression.interpret({'x': 10, 'y': 20})); // 30
}
```
> 📄 [الكود المصدري | View source code](lib/interpreter.dart)

---

<a id="iterator"></a>

## 16. المُكرِّر | Iterator

**الوصف:** يُوفِّر طريقة للوصول التسلسلي لعناصر مجموعة دون كشف بنيتها الداخلية.

**Description:** Provides sequential access to a collection's elements without exposing its underlying structure.

| المصطلح بالعربية | English Term |
|---|---|
| المُجمِّع | Aggregate |
| المُكرِّر الفعلي | Concrete Iterator |

```dart
// DART EXAMPLE

class Song {
  final String title;
  final String artist;
  Song(this.title, this.artist);

  @override
  String toString() => '$title — $artist';
}

// المُكرِّر المُخصَّص — يتتبَّع موضع التنقُّل يدويًا
// Custom Iterator — tracks traversal position manually
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

// المُجمِّع — يُوفِّر المُكرِّر
// Aggregate — provides the iterator
class Playlist {
  final String name;
  final List<Song> _songs = [];

  Playlist(this.name);

  void add(Song song) => _songs.add(song);
  int get length => _songs.length;

  PlaylistIterator get iterator => PlaylistIterator(_songs);
}

void main() {
  // --- الاستخدام ---
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
> 📄 [الكود المصدري | View source code](lib/iterator_pattern.dart)

---

<a id="mediator"></a>

## 17. الوسيط | Mediator

**الوصف:** يُقلِّل الاعتماد المتبادل بجعل الكائنات تتواصل عبر **وسيط** بدلًا من التواصل المباشر.

**Description:** Reduces direct coupling by making objects communicate through a **mediator** instead of directly.

| المصطلح بالعربية | English Term |
|---|---|
| الزميل | Colleague |
| الوسيط الفعلي | Concrete Mediator |

```dart
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
      print('$name تلقّى من | received from $from: $message');
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final room = ChatRoom();
  final ali = User('Ali');
  final sara = User('Sara');
  room..register(ali)..register(sara);

  ali.send('مرحبًا! | Hello!');
  // Sara تلقّى من | received from Ali: مرحبًا! | Hello!
}
```
> 📄 [الكود المصدري | View source code](lib/mediator.dart)

---

<a id="memento"></a>

## 18. التذكار | Memento

**الوصف:** يحفظ الحالة الداخلية لكائن في لقطة (Snapshot) لاستعادتها لاحقًا دون كسر التغليف.

**Description:** Captures an object's internal state in a snapshot to restore it later without violating encapsulation.

| المصطلح بالعربية | English Term |
|---|---|
| المُنشئ | Originator |
| الحارس | Caretaker |

```dart
// DART EXAMPLE

// --- اللقطة ---
// --- Snapshot ---
class EditorMemento {
  final String content;
  EditorMemento(this.content);
}

// --- المُنشئ ---
// --- Originator ---
class Editor {
  String content = '';

  EditorMemento save() => EditorMemento(content);
  void restore(EditorMemento memento) => content = memento.content;
}

// --- الحارس ---
// --- Caretaker ---
class History {
  final _snapshots = <EditorMemento>[];

  void push(EditorMemento memento) => _snapshots.add(memento);
  EditorMemento? pop() =>
      _snapshots.isNotEmpty ? _snapshots.removeLast() : null;
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final editor = Editor();
  final history = History();

  editor.content = 'الفصل الأول | Chapter 1';
  history.push(editor.save());

  editor.content = 'الفصل الثاني | Chapter 2';
  history.push(editor.save());

  editor.content = 'نص خاطئ! | Wrong text!';

  // استعادة آخر لقطة | Restore last snapshot
  editor.restore(history.pop()!);
  print(editor.content); // الفصل الثاني | Chapter 2
}
```
> 📄 [الكود المصدري | View source code](lib/memento.dart)

---

<a id="observer"></a>

## 19. المُراقِب | Observer

**الوصف:** يُعرِّف علاقة **واحد-إلى-كثير**، بحيث عندما يتغيَّر كائن يُخطَر جميع المُعتمِدين عليه تلقائيًا.

**Description:** Defines a **one-to-many** dependency, so when one object changes state, all dependents are notified automatically.

| المصطلح بالعربية | English Term |
|---|---|
| الموضوع | Subject |
| المُراقِب | Observer |
| الإخطار | Notify |

```dart
// DART EXAMPLE

class EventEmitter<T> {
  final _listeners = <void Function(T)>[];

  // الاشتراك | Subscribe
  void on(void Function(T) listener) => _listeners.add(listener);
  // إلغاء الاشتراك | Unsubscribe
  void off(void Function(T) listener) => _listeners.remove(listener);
  // إخطار الجميع | Notify all
  void emit(T event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final priceTracker = EventEmitter<double>();

  priceTracker.on((price) => print('📊 السعر الجديد | New price: $price'));
  priceTracker.on((price) {
    if (price < 50) print('🔔 تنبيه: منخفض! | Alert: Low!');
  });

  priceTracker.emit(75.0); // 📊 السعر الجديد | New price: 75.0
  priceTracker.emit(45.0); // 📊 ... + 🔔 تنبيه | Alert
}
```
> 📄 [الكود المصدري | View source code](lib/observer.dart)

---

<a id="state"></a>

## 20. الحالة | State

**الوصف:** يسمح للكائن بتغيير سلوكه عندما تتغيَّر حالته الداخلية. يبدو كأنه غيَّر صنفه.

**Description:** Allows an object to change its behavior when its internal state changes. The object appears to change its class.

| المصطلح بالعربية | English Term |
|---|---|
| السياق | Context |
| الحالة الفعلية | Concrete State |

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
  String get status => 'قيد الانتظار | Pending';
}

class ProcessingState implements OrderState {
  @override
  void next(Order order) => order.state = DeliveredState();
  @override
  String get status => 'قيد المعالجة | Processing';
}

class DeliveredState implements OrderState {
  @override
  void next(Order order) =>
      print('اكتمل بالفعل! | Already completed!');
  @override
  String get status => 'تم التوصيل | Delivered';
}

class Order {
  OrderState state = PendingState();
  void proceed() => state.next(this);
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final order = Order();
  print(order.state.status); // قيد الانتظار | Pending
  order.proceed();
  print(order.state.status); // قيد المعالجة | Processing
  order.proceed();
  print(order.state.status); // تم التوصيل | Delivered
}
```
> 📄 [الكود المصدري | View source code](lib/state.dart)

---

<a id="strategy"></a>

## 21. الاستراتيجية | Strategy

**الوصف:** يُعرِّف عائلة من الخوارزميات قابلة للتبديل أثناء التشغيل (Runtime).

**Description:** Defines a family of interchangeable algorithms, allowing you to swap them at runtime.

| المصطلح بالعربية | English Term |
|---|---|
| السياق | Context |
| الاستراتيجية الفعلية | Concrete Strategy |

```dart
// DART EXAMPLE

typedef SortStrategy = List<int> Function(List<int> data);

// --- استراتيجية الفقاعات ---
// --- Bubble Sort Strategy ---
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

// --- استراتيجية سريعة ---
// --- Quick Sort Strategy ---
List<int> quickSort(List<int> data) => (List.of(data)..sort());

class Sorter {
  SortStrategy strategy;
  Sorter(this.strategy);

  List<int> sort(List<int> data) => strategy(data);
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final sorter = Sorter(bubbleSort);
  print(sorter.sort([3, 1, 2])); // [1, 2, 3]

  // تبديل الاستراتيجية أثناء التشغيل
  // Swap strategy at runtime
  sorter.strategy = quickSort;
  print(sorter.sort([9, 5, 7])); // [5, 7, 9]
}
```
> 📄 [الكود المصدري | View source code](lib/strategy.dart)

---

<a id="template-method"></a>

## 22. أسلوب القالب | Template Method

**الوصف:** يُحدِّد الهيكل العام للخوارزمية ويترك بعض الخطوات للأصناف الفرعية.

**Description:** Defines the algorithm's skeleton and lets subclasses override specific steps.

| المصطلح بالعربية | English Term |
|---|---|
| دالّة الخُطّاف | Hook Method |
| العملية الأوّلية | Primitive Operation |

```dart
// DART EXAMPLE

abstract class DataExporter {
  // أسلوب القالب — الهيكل الثابت
  // Template Method — the fixed skeleton
  void export() {
    final data = fetchData();
    final formatted = format(data);
    save(formatted);
  }

  List<String> fetchData();          // عملية أوّلية | Primitive operation
  String format(List<String> data);  // عملية أوّلية | Primitive operation
  void save(String output) =>
      print('💾 حفظ | Saved: $output'); // خُطّاف | Hook
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
  // --- الاستخدام ---
  // --- Usage ---
  CsvExporter().export();  // 💾 حفظ | Saved: name,age,city
  JsonExporter().export(); // 💾 حفظ | Saved: {"fields": ["name", "age", "city"]}
}
```
> 📄 [الكود المصدري | View source code](lib/template_method.dart)

---

<a id="visitor"></a>

## 23. الزائر | Visitor

**الوصف:** يفصل **العمليات** عن **بنية الكائنات**. يُتيح إضافة عمليات جديدة دون تعديل الأصناف.

**Description:** Separates **operations** from the **object structure**. Allows adding new operations without modifying element classes.

| المصطلح بالعربية | English Term |
|---|---|
| العنصر | Element |
| الزائر الفعلي | Concrete Visitor |
| دالّة القبول | Accept Method |

```dart
// DART EXAMPLE

// --- العناصر ---
// --- Elements ---
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

// --- الزائر ---
// --- Visitor ---
abstract class ShapeVisitor {
  void visitCircle(Circle circle);
  void visitRectangle(Rectangle rectangle);
}

// --- زائر حساب المساحة ---
// --- Area Calculator Visitor ---
class AreaCalculator implements ShapeVisitor {
  @override
  void visitCircle(Circle c) =>
      print('مساحة الدائرة | Circle area: ${3.14159 * c.radius * c.radius}');

  @override
  void visitRectangle(Rectangle r) =>
      print('مساحة المستطيل | Rectangle area: ${r.width * r.height}');
}


void main() {
  // --- الاستخدام ---
  // --- Usage ---
  final shapes = <Shape>[Circle(5), Rectangle(4, 6)];
  final calculator = AreaCalculator();

  for (final shape in shapes) {
    shape.accept(calculator);
  }
  // مساحة الدائرة | Circle area: 78.53975
  // مساحة المستطيل | Rectangle area: 24.0
}
```
> 📄 [الكود المصدري | View source code](lib/visitor.dart)

---

# رابعًا: أنماط إضافية (خارج GoF) | Part IV: Additional Patterns (Beyond GoF)

> ⚠️ الأنماط التالية **ليست** من الـ 23 نمطًا الأساسيين (GoF). هي أنماط حديثة ومُكمِّلة ظهرت وتطوَّرت بعد كتاب GoF (1994).
>
> ⚠️ The following patterns are **NOT** part of the original 23 GoF patterns. They are modern, complementary patterns that emerged after the GoF book (1994).

---

## إنشائي إضافي | Additional Creational

---

<a id="object-pool"></a>

## 24. تجمُّع الكائنات | Object Pool

> 🏷️ **ليس من GoF** — نمط كلاسيكي من التسعينيات، شائع في إدارة الموارد المُكلفة.
>
> 🏷️ **Not GoF** — Classic 1990s pattern, common for managing expensive resources.

**الوصف:** يُدير مجموعة من الكائنات القابلة لإعادة الاستخدام لتجنُّب تكلفة الإنشاء والتدمير المتكرر.

**Description:** Manages a pool of reusable objects to avoid the cost of repeated creation and destruction.

| المصطلح بالعربية | English Term |
|---|---|
| التجمُّع | Pool |
| الاستحواذ | Acquire |
| التحرير | Release |

```dart
// DART EXAMPLE

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
  final pool = ConnectionPool(maxSize: 2);

  final conn1 = pool.acquire(); // ⏳ Creating connection #1
  final conn2 = pool.acquire(); // ⏳ Creating connection #2
  print(conn1.query('SELECT * FROM users'));

  pool.release(conn1);          // 🔓 Released connection #1
  final conn3 = pool.acquire(); // ♻️ Reusing connection #1

  print(identical(conn1, conn3)); // true — نفس الكائن | same object
  pool.release(conn2);
  pool.release(conn3);
}
```
> 📄 [الكود المصدري | View source code](lib/object_pool.dart)

> **متى تستخدمه؟** عند إنشاء كائنات مُكلفة (اتصالات شبكة، threads) وتريد إعادة استخدامها.
>
> **When to use?** When creating expensive objects (connections, threads) and you want to reuse them.

---

<a id="dependency-injection"></a>

## 25. حقن الاعتمادية | Dependency Injection

> 🏷️ **ليس من GoF** — صاغه Martin Fowler عام 2004. أساسي في تطبيقات Flutter/Dart الحديثة.
>
> 🏷️ **Not GoF** — Coined by Martin Fowler in 2004. Essential in modern Flutter/Dart apps.

**الوصف:** يُوفِّر الاعتماديات من الخارج بدلًا من أن يُنشئها الصنف بنفسه، مما يُحسِّن قابلية الاختبار والمرونة.

**Description:** Provides dependencies from the outside instead of having classes create their own, improving testability and flexibility.

| المصطلح بالعربية | English Term |
|---|---|
| حقن المُنشئ | Constructor Injection |
| الاعتمادية | Dependency |
| عكس التحكُّم | Inversion of Control |

```dart
// DART EXAMPLE

abstract class EmailService {
  void send(String to, String body);
}

class SmtpEmailService implements EmailService {
  @override
  void send(String to, String body) => print('📧 SMTP → $to: $body');
}

// خدمة وهمية للاختبار | Fake for testing
class FakeEmailService implements EmailService {
  final sent = <String>[];
  @override
  void send(String to, String body) {
    sent.add('$to: $body');
    print('🧪 Fake → $to: $body');
  }
}

// حقن المُنشئ — الاعتمادية تأتي من الخارج
// Constructor Injection — dependency comes from outside
class UserService {
  final EmailService _emailService;
  UserService(this._emailService);

  void register(String email) {
    print('✅ User registered: $email');
    _emailService.send(email, 'Welcome!');
  }
}


void main() {
  // إنتاج: حقن الخدمة الحقيقية | Production: inject real service
  UserService(SmtpEmailService()).register('user@example.com');
  // ✅ User registered: user@example.com
  // 📧 SMTP → user@example.com: Welcome!

  print('---');

  // اختبار: حقن خدمة وهمية | Testing: inject fake service
  final fakeEmail = FakeEmailService();
  UserService(fakeEmail).register('test@example.com');
  print('Sent: ${fakeEmail.sent}');
  // [test@example.com: Welcome!]
}
```
> 📄 [الكود المصدري | View source code](lib/dependency_injection.dart)

> **متى تستخدمه؟** دائمًا! خاصة عند الحاجة لاختبار الوحدات أو تبديل التنفيذات.
>
> **When to use?** Always! Especially when you need unit testing or swappable implementations.

---

<a id="multiton"></a>

## 26. المُتعدِّد | Multiton

> 🏷️ **ليس من GoF** — امتداد لنمط Singleton. يُدير سجلًا من النُّسخ المُسمَّاة.
>
> 🏷️ **Not GoF** — Extension of the Singleton pattern. Manages a registry of named instances.

**الوصف:** مثل Singleton، لكن يحتفظ بسجل من النُّسخ المُفهرسة بمفتاح. كل مفتاح يُعطي نسخة واحدة فقط.

**Description:** Like Singleton, but maintains a registry of instances indexed by key. Each key maps to exactly one instance.

| المصطلح بالعربية | English Term |
|---|---|
| المفتاح | Key |
| السجل | Registry |

```dart
// DART EXAMPLE

class Logger {
  static final Map<String, Logger> _instances = {};

  final String channel;
  Logger._internal(this.channel);

  // مصنع يُرجع نسخة واحدة لكل قناة
  // Factory returns one instance per channel
  factory Logger(String channel) {
    return _instances.putIfAbsent(channel, () {
      print('🆕 Creating logger for "$channel"');
      return Logger._internal(channel);
    });
  }

  void log(String message) => print('[$channel] $message');
}


void main() {
  final authLogger1 = Logger('auth');    // 🆕 Creating
  final authLogger2 = Logger('auth');    // مُعاد استخدام | Reused
  final dbLogger = Logger('database');   // 🆕 Creating

  print(identical(authLogger1, authLogger2)); // true — نفس النسخة | same
  print(identical(authLogger1, dbLogger));    // false — مختلفة | different

  authLogger1.log('User logged in');   // [auth] User logged in
  dbLogger.log('Query executed');      // [database] Query executed
}
```
> 📄 [الكود المصدري | View source code](lib/multiton.dart)

> **متى تستخدمه؟** عندما تحتاج نسخة واحدة لكل فئة/قناة (مثل loggers, database connections بحسب الاسم).
>
> **When to use?** When you need one instance per category/channel (e.g., loggers, named connections).

---

## بنائي إضافي | Additional Structural

---

<a id="extension-object"></a>

## 27. كائن الامتداد | Extension Object

> 🏷️ **ليس من GoF** — اقترحه Erich Gamma عام 1996. دارت تدعمه أصلًا عبر `extension methods` (منذ Dart 2.7، 2019).
>
> 🏷️ **Not GoF** — Proposed by Erich Gamma in 1996. Dart has first-class support via `extension methods` (since Dart 2.7, 2019).

**الوصف:** يُضيف وظائف جديدة لأنواع موجودة **دون تعديلها**. في دارت، يتم ذلك عبر `extension`.

**Description:** Adds new functionality to existing types **without modifying them**. In Dart, this is done via `extension`.

| المصطلح بالعربية | English Term |
|---|---|
| الامتداد | Extension |
| النوع الأصلي | Base Type |

```dart
// DART EXAMPLE

// إضافة قدرات لـ String
// Adding capabilities to String
extension StringFormatting on String {
  String get titleCase => split(' ')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
      .join(' ');

  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}…';

  bool get isEmail => RegExp(r'^[\w\-.]+@[\w\-.]+\.\w+$').hasMatch(this);
}

// إضافة إحصائيات لـ List<num>
// Adding statistics to List<num>
extension NumListStats on List<num> {
  num get sum => fold<num>(0, (a, b) => a + b);
  double get average => isEmpty ? 0 : sum / length;
}


void main() {
  print('hello world'.titleCase);        // Hello World
  print('Long text here'.truncate(8));   // Long tex…
  print('user@mail.com'.isEmail);        // true

  final List<num> scores = [85, 92, 78, 95, 88];
  print('Sum: ${scores.sum}');       // Sum: 438
  print('Average: ${scores.average}'); // Average: 87.6
}
```
> 📄 [الكود المصدري | View source code](lib/extension_object.dart)

> **متى تستخدمه؟** عند الحاجة لإضافة دوال مساعدة لأنواع لا تتحكم فيها (String, int, List...).
>
> **When to use?** When adding helper methods to types you don't control (String, int, List...).

---

<a id="value-object"></a>

## 28. كائن القيمة | Value Object

> 🏷️ **ليس من GoF** — من كتاب Domain-Driven Design لـ Eric Evans (2003). أساسي في البرمجة الوظيفية.
>
> 🏷️ **Not GoF** — From Eric Evans' Domain-Driven Design (2003). Fundamental in functional programming.

**الوصف:** كائن غير قابل للتغيير (Immutable) تُحدَّد مساواته بقيمته لا بهويته. كائنان بنفس البيانات مُتساويان.

**Description:** An immutable object whose equality is based on its **value**, not its identity. Two objects with the same data are equal.

| المصطلح بالعربية | English Term |
|---|---|
| المساواة بالقيمة | Value Equality |
| غير قابل للتغيير | Immutable |
| عامل المساواة | Equality Operator |

```dart
// DART EXAMPLE

class Money {
  final double amount;
  final String currency;
  const Money(this.amount, this.currency);

  Money operator +(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot add $currency and ${other.currency}');
    }
    return Money(amount + other.amount, currency);
  }

  Money operator *(num factor) => Money(amount * factor, currency);

  // المساواة بالقيمة — ليس بالهوية
  // Equality by value — not by identity
  @override
  bool operator ==(Object other) =>
      other is Money && amount == other.amount && currency == other.currency;

  @override
  int get hashCode => Object.hash(amount, currency);

  @override
  String toString() => '${amount.toStringAsFixed(2)} $currency';
}


void main() {
  const price = Money(29.99, 'SAR');
  const tax = Money(4.50, 'SAR');
  final total = price + tax;

  print('Total: $total'); // Total: 34.49 SAR
  print(price * 2);       // 59.98 SAR

  // المساواة بالقيمة | Value equality
  print(const Money(10, 'SAR') == const Money(10, 'SAR')); // true
}
```
> 📄 [الكود المصدري | View source code](lib/value_object.dart)

> **متى تستخدمه؟** لتمثيل المفاهيم المالية، الإحداثيات، الألوان — أي قيمة يُحدَّد معناها بمحتواها.
>
> **When to use?** For monetary values, coordinates, colors — any value defined by its content.

---

## سلوكي إضافي | Additional Behavioral

---

<a id="null-object"></a>

## 29. الكائن الفارغ | Null Object

> 🏷️ **ليس من GoF** — وصفه Bobby Woolf عام 1998. بديل أنيق لفحوصات `null`.
>
> 🏷️ **Not GoF** — Described by Bobby Woolf in 1998. An elegant alternative to `null` checks.

**الوصف:** يُوفِّر كائنًا افتراضيًا "لا يفعل شيئًا" بدلًا من `null`، مُزيلًا الحاجة لفحوصات null.

**Description:** Provides a default "do-nothing" object instead of `null`, eliminating the need for null checks.

| المصطلح بالعربية | English Term |
|---|---|
| الكائن الفارغ | Null Object |
| السلوك الافتراضي | Default Behavior |

```dart
// DART EXAMPLE

abstract class Logger {
  void log(String message);
}

class ConsoleLogger implements Logger {
  @override
  void log(String message) => print('📝 LOG: $message');
}

// الكائن الفارغ — لا يفعل شيئًا
// Null Object — does nothing
class NullLogger implements Logger {
  const NullLogger();
  @override
  void log(String message) { /* لا شيء | nothing */ }
}

class PaymentService {
  final Logger _logger;

  // لا حاجة لفحص null — NullLogger هو الافتراضي
  // No null check needed — NullLogger is the default
  PaymentService({Logger logger = const NullLogger()}) : _logger = logger;

  void processPayment(double amount) {
    _logger.log('Processing: \$${amount.toStringAsFixed(2)}');
    print('💰 Payment of \$${amount.toStringAsFixed(2)} processed');
    _logger.log('Completed');
  }
}


void main() {
  // مع تسجيل | With logging
  PaymentService(logger: ConsoleLogger()).processPayment(99.99);
  // 📝 LOG: Processing: $99.99
  // 💰 Payment of $99.99 processed

  print('---');

  // بدون تسجيل — بلا فحوصات null!
  // Without logging — no null checks needed!
  PaymentService().processPayment(49.99);
  // 💰 Payment of $49.99 processed
}
```
> 📄 [الكود المصدري | View source code](lib/null_object.dart)

> **متى تستخدمه؟** عند الحاجة لسلوك افتراضي "لا يفعل شيئًا" بدلًا من null وفحوصاته.
>
> **When to use?** When you need a "do-nothing" default behavior instead of null and its checks.

---

<a id="specification"></a>

## 30. المواصفة | Specification

> 🏷️ **ليس من GoF** — صاغه Eric Evans و Martin Fowler عام 2005. أساسي في Domain-Driven Design.
>
> 🏷️ **Not GoF** — Coined by Eric Evans & Martin Fowler in 2005. Central to Domain-Driven Design.

**الوصف:** يُغلِّف قواعد العمل (Business Rules) ككائنات قابلة للتركيب والدمج بعمليات AND و OR و NOT.

**Description:** Encapsulates business rules as composable objects that can be combined with AND, OR, and NOT operators.

| المصطلح بالعربية | English Term |
|---|---|
| المواصفة | Specification |
| التركيب | Composition |
| قاعدة العمل | Business Rule |

```dart
// DART EXAMPLE

abstract class Specification<T> {
  bool isSatisfiedBy(T candidate);

  // التركيب — AND, OR, NOT
  // Composition — AND, OR, NOT
  Specification<T> and(Specification<T> other) => _AndSpec(this, other);
  Specification<T> or(Specification<T> other) => _OrSpec(this, other);
  Specification<T> not() => _NotSpec(this);
}

class _AndSpec<T> extends Specification<T> {
  final Specification<T> _left, _right;
  _AndSpec(this._left, this._right);
  @override
  bool isSatisfiedBy(T c) => _left.isSatisfiedBy(c) && _right.isSatisfiedBy(c);
}

class _OrSpec<T> extends Specification<T> {
  final Specification<T> _left, _right;
  _OrSpec(this._left, this._right);
  @override
  bool isSatisfiedBy(T c) => _left.isSatisfiedBy(c) || _right.isSatisfiedBy(c);
}

class _NotSpec<T> extends Specification<T> {
  final Specification<T> _spec;
  _NotSpec(this._spec);
  @override
  bool isSatisfiedBy(T c) => !_spec.isSatisfiedBy(c);
}

// --- المجال | Domain ---

class Product {
  final String name;
  final double price;
  final String category;
  const Product(this.name, this.price, this.category);

  @override
  String toString() => '$name (\$$price, $category)';
}

class CheapProduct extends Specification<Product> {
  final double maxPrice;
  CheapProduct(this.maxPrice);
  @override
  bool isSatisfiedBy(Product p) => p.price <= maxPrice;
}

class InCategory extends Specification<Product> {
  final String category;
  InCategory(this.category);
  @override
  bool isSatisfiedBy(Product p) => p.category == category;
}


void main() {
  final products = [
    const Product('Phone', 999, 'Electronics'),
    const Product('Book', 15, 'Education'),
    const Product('Cable', 8, 'Electronics'),
    const Product('Pen', 2, 'Education'),
  ];

  // قواعد عمل قابلة للتركيب
  // Composable business rules
  final cheapElectronics = CheapProduct(50).and(InCategory('Electronics'));

  print('Cheap Electronics:');
  products.where(cheapElectronics.isSatisfiedBy).forEach(print);
  // Cable ($8.0, Electronics)
}
```
> 📄 [الكود المصدري | View source code](lib/specification.dart)

> **متى تستخدمه؟** عند وجود قواعد تصفية مُعقَّدة يمكن تركيبها ديناميكيًا.
>
> **When to use?** When you have complex filtering rules that can be composed dynamically.

---

<a id="service-locator"></a>

## 31. مُحدِّد الخدمات | Service Locator

> 🏷️ **ليس من GoF** — وصفه Martin Fowler عام 2004. بديل لـ Dependency Injection في الإعدادات البسيطة (مثل `get_it` في Flutter).
>
> 🏷️ **Not GoF** — Described by Martin Fowler in 2004. Alternative to DI for simpler setups (like `get_it` in Flutter).

**الوصف:** سجل مركزي يُوفِّر وصولًا عامًا للخدمات حسب نوعها.

**Description:** A central registry that provides global access to services by type.

| المصطلح بالعربية | English Term |
|---|---|
| السجل | Registry |
| مُحدِّد الخدمات | Service Locator |
| نقطة الوصول | Access Point |

```dart
// DART EXAMPLE

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  final _singletons = <Type, Object>{};
  ServiceLocator._internal();
  factory ServiceLocator() => _instance;

  // تسجيل خدمة | Register a service
  void register<T extends Object>(T instance) {
    _singletons[T] = instance;
  }

  // استرجاع خدمة | Retrieve a service
  T get<T extends Object>() {
    final service = _singletons[T];
    if (service == null) throw StateError('Not registered: $T');
    return service as T;
  }

  void reset() => _singletons.clear();
}

// --- مثال | Example ---

abstract class AnalyticsService {
  void track(String name);
}

class FirebaseAnalytics implements AnalyticsService {
  @override
  void track(String name) => print('🔥 Firebase: $name');
}

class FakeAnalytics implements AnalyticsService {
  @override
  void track(String name) => print('🧪 Fake: $name');
}


void main() {
  final locator = ServiceLocator();

  // تسجيل | Register
  locator.register<AnalyticsService>(FirebaseAnalytics());

  // استرجاع من أي مكان | Retrieve from anywhere
  locator.get<AnalyticsService>().track('page_view');
  // 🔥 Firebase: page_view

  // للاختبار: تبديل التنفيذ | For testing: swap
  locator.reset();
  locator.register<AnalyticsService>(FakeAnalytics());
  locator.get<AnalyticsService>().track('page_view');
  // 🧪 Fake: page_view
}
```
> 📄 [الكود المصدري | View source code](lib/service_locator.dart)

> **متى تستخدمه؟** عند الحاجة لوصول عام للخدمات بدون تمرير يدوي (مثل حزمة `get_it` في Flutter).
>
> **When to use?** When you need global service access without manual passing (like the `get_it` package in Flutter).

---

<a id="repository"></a>

## 32. المستودع | Repository

> 🏷️ **ليس من GoF** — من كتاب Domain-Driven Design لـ Eric Evans (2003). شائع جدًا في Flutter.
>
> 🏷️ **Not GoF** — From Eric Evans' Domain-Driven Design (2003). Very common in Flutter.

**الوصف:** يُجرِّد الوصول للبيانات خلف واجهة تُشبه المجموعة (Collection)، فاصلًا منطق المجال عن تفاصيل التخزين.

**Description:** Abstracts data access behind a collection-like interface, decoupling domain logic from storage details.

| المصطلح بالعربية | English Term |
|---|---|
| المستودع | Repository |
| مصدر البيانات | Data Source |
| الكيان | Entity |

```dart
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
  final UserRepository repo = InMemoryUserRepository();

  repo.save(const User(id: 1, name: 'Ali', email: 'ali@mail.com'));
  repo.save(const User(id: 2, name: 'Sara', email: 'sara@mail.com'));

  print('All: ${repo.findAll()}');   // [User(1, Ali), User(2, Sara)]
  print('Find #1: ${repo.findById(1)}'); // User(1, Ali)

  repo.delete(2);
  print('After delete: ${repo.findAll()}'); // [User(1, Ali)]
}
```
> 📄 [الكود المصدري | View source code](lib/repository.dart)

> **متى تستخدمه؟** دائمًا في تطبيقات Flutter لعزل طبقة البيانات عن منطق التطبيق.
>
> **When to use?** Always in Flutter apps to isolate the data layer from application logic.

---

<a id="summary"></a>

# 📊 التوزيع النهائي | Summary

## الأنماط الأساسية (GoF 23) | Core Patterns (GoF 23)

| الفئة | Category | العدد | Count |
|---|---|:---:|:---:|
| الإنشائية | Creational | 5 | 5 |
| البنائية | Structural | 7 | 7 |
| السلوكية | Behavioral | 11 | 11 |
| **الإجمالي** | **Total** | **23** | **23** |

## الأنماط الإضافية (خارج GoF) | Additional Patterns (Beyond GoF)

| # | النمط — Pattern | الفئة — Category | الأصل — Origin |
|---|---|---|---|
| 24 | تجمُّع الكائنات — Object Pool | إنشائي — Creational | كلاسيكي (1990s) |
| 25 | حقن الاعتمادية — Dependency Injection | إنشائي — Creational | Fowler (2004) |
| 26 | المُتعدِّد — Multiton | إنشائي — Creational | امتداد Singleton |
| 27 | كائن الامتداد — Extension Object | بنائي — Structural | Gamma (1996) / Dart 2.7 |
| 28 | كائن القيمة — Value Object | بنائي — Structural | Evans DDD (2003) |
| 29 | الكائن الفارغ — Null Object | سلوكي — Behavioral | Woolf (1998) |
| 30 | المواصفة — Specification | سلوكي — Behavioral | Evans & Fowler (2005) |
| 31 | مُحدِّد الخدمات — Service Locator | سلوكي — Behavioral | Fowler (2004) |
| 32 | المستودع — Repository | سلوكي — Behavioral | Evans DDD (2003) |

---

# 🧠 الخلاصة | Quick Mental Model

| الفئة — Category | السؤال — Core Question | أشهر الأمثلة — Examples |
|---|---|---|
| **الإنشائية — Creational** | كيف نُنشئ؟ — How do we create? | Singleton, Factory, DI |
| **البنائية — Structural** | كيف نُركِّب؟ — How do we compose? | Adapter, Decorator, Extension |
| **السلوكية — Behavioral** | كيف نتواصل؟ — How do we communicate? | Observer, Strategy, Repository |
