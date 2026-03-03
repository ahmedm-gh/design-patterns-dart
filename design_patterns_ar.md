> [ENGLISH VERSION (HERE)](design_patterns_en.md) | [BILINGUAL VERSION | النسخة المدمجة](design_patterns_bilingual.md)
# أنماط التصميم (Design Patterns)

**الأنماط الثلاثة والعشرون الأساسية (Gang of Four) — شرح مُفصَّل بأمثلة Dart**

> أنماط التصميم هي حلول مُجرَّبة ومُعاد استخدامها لمشكلات شائعة في تصميم البرمجيات.
> لا تُمثِّل كودًا جاهزًا، بل هي **قوالب فكرية** (Templates) يمكن تطبيقها على مواقف مختلفة.

---

# أولًا: الأنماط الإنشائية (Creational Patterns)

> تُجيب على سؤال: **كيف نُنشئ الكائنات (Objects) بطريقة مرنة وقابلة للتوسُّع؟**
>
> بدلًا من إنشاء الكائنات مباشرةً باستخدام `new`، تُوفِّر هذه الأنماط آليات تحكُّم في عملية الإنشاء (Instantiation) بما يُناسب السياق.

---

## 1. المصنع المُجرَّد (Abstract Factory)

**الوصف:** يُوفِّر واجهة (Interface) لإنشاء **عائلة من الكائنات المترابطة** دون تحديد أصنافها (Classes) الفعلية. يضمن أن المنتجات (Products) المُنشأة تتوافق مع بعضها.

**المشكلة:** تحتاج إنشاء مجموعة كائنات مترابطة (مثلًا: أزرار ونوافذ لنظام معيَّن) دون ربط الكود بأنواع محددة.

**الحل:** أنشئ واجهة مصنع مُجرَّدة، ثم أنشئ مصنعًا فعليًا (Concrete Factory) لكل عائلة مُنتَجات.

**المصطلحات:**
- **المصنع المُجرَّد (Abstract Factory):** الواجهة التي تُعلِن عن دوالّ الإنشاء
- **المصنع الفعلي (Concrete Factory):** التنفيذ الذي يُنشئ منتجات عائلة مُحدَّدة
- **المُنتَج المُجرَّد (Abstract Product):** الواجهة المشتركة للمنتجات
- **عائلة المُنتَجات (Product Family):** مجموعة الكائنات المُتناسقة

```dart
// DART EXAMPLE

// --- المُنتَجات المُجرَّدة ---
abstract class Button {
  String render();
}

abstract class TextField {
  String render();
}

// --- المُنتَجات الفعلية ---
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
abstract class WidgetFactory {
  Button createButton();
  TextField createTextField();
}

// --- المصانع الفعلية ---
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

  // CupertinoFactory
  buildUI(CupertinoFactory());
}
```

**متى تستخدمه؟** عندما يحتاج تطبيقك دعم منصات أو سمات (Themes) مختلفة بعناصر واجهة متناسقة.

---

## 2. الباني (Builder)

**الوصف:** يفصل بناء كائن مُعقَّد عن تمثيله، بحيث يمكن لنفس عملية البناء إنتاج تمثيلات مختلفة. بدلًا من مُنشئ (Constructor) ضخم مليء بالمُعامِلات (Parameters)، تبني الكائن **خطوة بخطوة**.

**المشكلة:** مُنشئ يحتوي عشرات المُعامِلات، أغلبها اختياري، مما يجعل الكود صعب القراءة والصيانة.

**الحل:** استخرج خطوات البناء في كائن مُنفصل (Builder)، واستخدم مُوجِّهًا (Director) اختياريًا لتنسيق الخطوات.

**المصطلحات:**
- **الباني (Builder):** الواجهة التي تُحدِّد خطوات البناء
- **الباني الفعلي (Concrete Builder):** التنفيذ الذي يبني ويُجمِّع الأجزاء
- **المُوجِّه (Director):** يُنسِّق ترتيب خطوات البناء (اختياري)
- **المُنتَج (Product):** الكائن المُعقَّد النهائي

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
    return this; // لتمكين سلسلة الاستدعاءات (Method Chaining)
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
  // --- الاستخدام ---
  final pizza = PizzaBuilder()
      .setSize('Large')
      .setCrust('Thin')
      .addTopping('Cheese')
      .addTopping('Olives')
      .build();

  print(pizza); // Pizza(Large, Thin, toppings: [Cheese, Olives])
}
```

**متى تستخدمه؟** عندما يكون لديك كائن يحتوي خيارات بناء كثيرة ومتنوعة.

---

## 3. دالّة المصنع (Factory Method)

**الوصف:** يُحدِّد واجهة لإنشاء كائن، لكنه يترك قرار **أي صنف يتم إنشاؤه** للأصناف الفرعية (Subclasses). يُحوِّل استدعاء `new` المباشر إلى استدعاء دالّة مصنع مُتخصِّصة.

**المشكلة:** تريد فصل منطق الإنشاء عن كود الاستخدام، بحيث يسهل إضافة أنواع جديدة دون تعديل الكود الموجود.

**الحل:** عرِّف دالّة مسؤولة عن الإنشاء في الصنف الأب، ودع الأصناف الفرعية تُعيد تعريفها.

**المصطلحات:**
- **المُنشئ (Creator):** الصنف الذي يحتوي دالّة المصنع
- **المُنشئ الفعلي (Concrete Creator):** الصنف الفرعي الذي يُنفِّذ دالّة المصنع
- **المُنتَج (Product):** الكائن الذي تُرجعه دالّة المصنع

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

// --- دالّة المصنع ---
Notification createNotification(String type) {
  return switch (type) {
    'email' => EmailNotification(),
    'sms'   => SmsNotification(),
    'push'  => PushNotification(),
    _       => throw ArgumentError('نوع إشعار غير معروف: $type'),
  };
}


void main() {
  // --- الاستخدام ---
  final notification = createNotification('email');
  notification.send('مرحبًا!'); // Email: مرحبًا!
}
```

**متى تستخدمه؟** عندما لا تعرف مُسبقًا النوع الدقيق للكائنات التي سيُنشئها الكود.

---

## 4. النموذج الأوَّلي (Prototype)

**الوصف:** يُنشئ كائنات جديدة عن طريق **نسخ** (Cloning) كائن موجود بدلًا من بنائه من الصفر. مفيد عندما يكون إنشاء الكائن مُكلِّفًا أو يتطلب إعدادات معقدة.

**المشكلة:** إنشاء كائن مُكلِّف (مثلًا: يتطلب اتصالًا بقاعدة بيانات أو حسابات ثقيلة)، وتحتاج نُسخًا عديدة بإعدادات مشابهة.

**الحل:** عرِّف دالّة `clone()` في الكائن الأصلي لإنشاء نسخة مستقلة منه.

**المصطلحات:**
- **النسخ (Cloning):** إنشاء نسخة من كائن موجود
- **النسخ العميق (Deep Copy):** نسخ الكائن وجميع كائناته الداخلية
- **النسخ السطحي (Shallow Copy):** نسخ الكائن فقط مع مشاركة المراجع الداخلية

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

  // نسخ عميق (Deep Copy)
  GameConfig clone() {
    return GameConfig(
      difficulty: difficulty,
      maxPlayers: maxPlayers,
      enabledModes: List.from(enabledModes), // نسخ القائمة لا مشاركتها
    );
  }
}


void main() {
  // --- الاستخدام ---
  final defaultConfig = GameConfig(
    difficulty: 'Normal',
    maxPlayers: 4,
    enabledModes: ['Survival', 'Creative'],
  );

  final customConfig = defaultConfig.clone()
    ..difficulty = 'Hard'
    ..enabledModes.add('Adventure');

  print(defaultConfig.enabledModes); // [Survival, Creative] — لم تتأثر
  print(customConfig.enabledModes);  // [Survival, Creative, Adventure]
}
```

**متى تستخدمه؟** عندما تريد إنشاء كائنات مُشابهة بتكلفة أقل من البناء الكامل.

---

## 5. الكائن الوحيد (Singleton)

**الوصف:** يضمن أن الصنف لديه **نسخة واحدة فقط** (Instance) طوال عمر التطبيق، ويُوفِّر نقطة وصول عامة (Global Access Point) لها.

**المشكلة:** تحتاج نسخة واحدة مُشتركة من خدمة ما (مثلًا: إعدادات التطبيق، اتصال قاعدة البيانات)، ولا يجب إنشاء أكثر من نسخة.

**الحل:** اجعل المُنشئ خاصًا (Private Constructor)، واستخدم خاصية ثابتة (Static) لحفظ النسخة الوحيدة.

**المصطلحات:**
- **نقطة الوصول العامة (Global Access Point):** الطريقة الوحيدة للحصول على النسخة
- **التهيئة الكسولة (Lazy Initialization):** إنشاء النسخة عند أول طلب فقط
- **التهيئة الفورية (Eager Initialization):** إنشاء النسخة فور تحميل الصنف

```dart
// DART EXAMPLE

class AppConfig {
  // Dart يضمن أن الحقول static final تُهيَّأ مرة واحدة (Lazy بشكل تلقائي)
  static final AppConfig _instance = AppConfig._internal();

  String appName = 'MyApp';
  bool debugMode = false;

  // مُنشئ خاص — لا يمكن إنشاء نُسخ من خارج الصنف
  AppConfig._internal();

  // مُنشئ المصنع يُرجع النسخة الوحيدة دائمًا
  factory AppConfig() => _instance;
}


void main() {
  // --- الاستخدام ---
  final config1 = AppConfig();
  final config2 = AppConfig();
  config1.debugMode = true;

  print(identical(config1, config2)); // true — نفس النسخة
  print(config2.debugMode);           // true — التغيير ظهر في كليهما
}
```

**متى تستخدمه؟** عندما تحتاج نسخة واحدة مُشتركة يصل إليها التطبيق بالكامل.

---

# ثانيًا: الأنماط البنائية (Structural Patterns)

> تُجيب على سؤال: **كيف نُركِّب الكائنات والأصناف معًا بشكل مرن وفعَّال؟**
>
> تهتم بتنظيم العلاقات بين الكائنات لتكوين هياكل أكبر مع الحفاظ على المرونة.

---

## 6. المُحوِّل (Adapter)

**الوصف:** يُحوِّل واجهة صنف إلى واجهة أخرى يتوقعها العميل (Client). يعمل كـ**جسر توافق** بين واجهتين غير متوافقتين.

**المشكلة:** لديك واجهة برمجية (API) قديمة أو خارجية لا تتوافق مع الكود الحالي.

**الحل:** أنشئ صنف وسيط (Wrapper) يُترجم الاستدعاءات بين الواجهتين.

**المصطلحات:**
- **الهدف (Target):** الواجهة التي يتوقعها العميل
- **المُتكيِّف معه (Adaptee):** الصنف القديم أو الخارجي ذو الواجهة غير المتوافقة
- **المُغلِّف (Wrapper):** صنف المُحوِّل نفسه

```dart
// DART EXAMPLE

// --- الواجهة المتوقعة (Target) ---
abstract class JsonLogger {
  void logJson(Map<String, dynamic> data);
}

// --- صنف قديم غير متوافق (Adaptee) ---
class LegacyFileLogger {
  void writeToFile(String text) => print('LOG FILE: $text');
}

// --- المُحوِّل (Adapter) ---
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
  final JsonLogger logger = FileLoggerAdapter(LegacyFileLogger());
  logger.logJson({'event': 'login', 'user': 'ahmad'}); // LOG FILE: event=login, user=ahmad
}
```

**متى تستخدمه؟** عند الحاجة لدمج مكتبة قديمة أو خارجية مع كودك الحالي.

---

## 7. الجسر (Bridge)

**الوصف:** يفصل **التجريد** (Abstraction) عن **التنفيذ** (Implementation) بحيث يتغيَّر كلٌّ منهما بشكل مستقل. يستخدم التركيب (Composition) بدلًا من الوراثة (Inheritance) لتجنُّب انفجار عدد الأصناف.

**المشكلة:** عند استخدام الوراثة لكل مزيج من الأبعاد (مثلًا: شكل × لون)، يتضاعف عدد الأصناف بشكل كبير.

**الحل:** افصل البُعدين في تسلسلي وراثة مستقلين، واربطهما عبر التركيب.

**المصطلحات:**
- **التجريد (Abstraction):** الواجهة العُليا التي يتعامل معها العميل
- **المُنفِّذ (Implementor):** الواجهة التي تُحدِّد عمليات التنفيذ
- **التجريد المُنقَّح (Refined Abstraction):** امتداد للتجريد الأصلي

```dart
// DART EXAMPLE

// --- التنفيذ (Implementor) ---
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

// --- التجريد (Abstraction) ---
class NotificationManager {
  final MessageSender _sender;
  NotificationManager(this._sender);

  void notify(String message) => _sender.sendMessage(message);
}

class UrgentNotification extends NotificationManager {
  UrgentNotification(super.sender);

  @override
  void notify(String message) => super.notify('🚨 عاجل: $message');
}


void main() {
  // --- الاستخدام ---
  final urgentSms = UrgentNotification(SmsSender());
  urgentSms.notify('الخادم توقف!'); // SMS: 🚨 عاجل: الخادم توقف!
}
```

**متى تستخدمه؟** عندما يكون لديك بُعدان مستقلان من التنوُّع وتريد تجنُّب انفجار عدد الأصناف.

---

## 8. المُركَّب (Composite)

**الوصف:** يُتيح التعامل مع **الكائنات المُفردة والمجموعات** بنفس الطريقة عبر بنية شجرية (Tree Structure). العميل لا يحتاج التمييز بين العنصر المُفرد والمجموعة.

**المشكلة:** لديك بنية هرمية (شجرية) وتريد تنفيذ عمليات على العناصر والمجموعات بطريقة موحَّدة.

**المصطلحات:**
- **المُكوِّن (Component):** الواجهة المُشتركة بين الأوراق والمُركَّبات
- **الورقة (Leaf):** عنصر نهائي لا يحتوي أبناء
- **المُركَّب (Composite):** عنصر يحتوي مجموعة من الأبناء

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
  // --- الاستخدام ---
  final root = Folder('root')
    ..add(File('readme.md', 100))
    ..add(Folder('src')..add(File('main.dart', 500))..add(File('utils.dart', 300)));

  print(root.getSize()); // 900
}
```

**متى تستخدمه؟** عند التعامل مع بنى شجرية (ملفات، قوائم، واجهات رسومية).

---

## 9. المُزخرِف (Decorator)

**الوصف:** يُضيف مسؤوليات جديدة لكائن **ديناميكيًا** دون تعديل صنفه الأصلي أو اللجوء لوراثة مُتعدِّدة. يُغلِّف الكائن بطبقة إضافية.

**المشكلة:** تريد إضافة ميزات متعددة اختيارية لكائن، والوراثة ستُنتج عشرات الأصناف لكل مزيج.

**المصطلحات:**
- **المُغلِّف (Wrapper):** الكائن المُزخرِف الذي يُغلِّف الكائن الأصلي
- **المُزخرِف الفعلي (Concrete Decorator):** التنفيذ المُحدَّد للسلوك الإضافي

```dart
// DART EXAMPLE

abstract class Coffee {
  String get description;
  double get cost;
}

class SimpleCoffee implements Coffee {
  @override
  String get description => 'قهوة بسيطة';
  @override
  double get cost => 5.0;
}

// --- مُزخرِفات ---
class MilkDecorator implements Coffee {
  final Coffee _coffee;
  MilkDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + حليب';
  @override
  double get cost => _coffee.cost + 1.5;
}

class SugarDecorator implements Coffee {
  final Coffee _coffee;
  SugarDecorator(this._coffee);

  @override
  String get description => '${_coffee.description} + سكر';
  @override
  double get cost => _coffee.cost + 0.5;
}


void main() {
  // --- الاستخدام ---
  Coffee order = SimpleCoffee();
  order = MilkDecorator(order);
  order = SugarDecorator(order);

  print(order.description); // قهوة بسيطة + حليب + سكر
  print(order.cost);        // 7.0
}
```

**متى تستخدمه؟** عند الحاجة لإضافة سلوكيات اختيارية ومُركَّبة لكائن بشكل ديناميكي.

---

## 10. الواجهة المُبسَّطة (Facade)

**الوصف:** يُوفِّر واجهة مُبسَّطة وموحَّدة لنظام فرعي مُعقَّد. يُخفي التعقيد الداخلي ويُقدِّم نقطة دخول واحدة سهلة الاستخدام.

**المشكلة:** نظام فرعي يتكوَّن من عدة أصناف متشابكة، والعميل لا يحتاج معرفة تفاصيلها.

**المصطلحات:**
- **النظام الفرعي (Subsystem):** مجموعة الأصناف المُعقَّدة خلف الكواليس
- **الواجهة الموحَّدة (Unified Interface):** نقطة الدخول البسيطة للعميل

```dart
// DART EXAMPLE

// --- أصناف النظام الفرعي المُعقَّد ---
class AudioDecoder {
  String decode(String file) => 'audio_data($file)';
}

class VideoDecoder {
  String decode(String file) => 'video_data($file)';
}

class ScreenRenderer {
  void render(String video, String audio) =>
      print('▶ عرض: $video مع $audio');
}

// --- الواجهة المُبسَّطة ---
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
  MediaPlayer().play('movie.mp4'); // ▶ عرض: video_data(movie.mp4) مع audio_data(movie.mp4)
}
```

**متى تستخدمه؟** عندما تريد تبسيط التخاطب مع نظام فرعي مُعقَّد.

---

## 11. وزن الذبابة (Flyweight)

**الوصف:** يُقلِّل استهلاك الذاكرة بمشاركة أكبر قدر ممكن من البيانات بين الكائنات المتشابهة. يفصل **الحالة الداخلية المُشتركة** (Intrinsic) عن **الحالة الخارجية المتغيِّرة** (Extrinsic).

**المشكلة:** تكرار كائنات كثيرة تحمل بيانات متطابقة جزئيًا يستهلك ذاكرة كبيرة.

**المصطلحات:**
- **الحالة الداخلية (Intrinsic State):** البيانات المُشتركة غير القابلة للتغيير
- **الحالة الخارجية (Extrinsic State):** البيانات الخاصة بكل سياق
- **مصنع وزن الذبابة (Flyweight Factory):** يُدير وُيعيد استخدام النُّسخ المُشتركة

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
  // --- الاستخدام ---
  final factory = StyleFactory();
  final s1 = factory.getStyle('Arial', 12);
  final s2 = factory.getStyle('Arial', 12);
  print(identical(s1, s2)); // true — نفس الكائن في الذاكرة
}
```

**متى تستخدمه؟** عند وجود آلاف الكائنات التي تتشارك بيانات مُتشابهة.

---

## 12. الوكيل (Proxy)

**الوصف:** يُوفِّر بديلًا أو نائبًا عن كائن آخر للتحكُّم في الوصول إليه. يعمل كحارس بوابة يُمكنه إضافة منطق قبل أو بعد الوصول للكائن الحقيقي.

**المشكلة:** تحتاج التحكُّم في كيفية ووقت الوصول لكائن مُكلِّف أو حسَّاس.

**المصطلحات:**
- **الموضوع الحقيقي (Real Subject):** الكائن الأصلي
- **الوكيل الافتراضي (Virtual Proxy):** يُؤخِّر إنشاء الكائن لحين الحاجة
- **وكيل الحماية (Protection Proxy):** يتحكَّم في صلاحيات الوصول

```dart
// DART EXAMPLE

abstract class Database {
  String query(String sql);
}

class RealDatabase implements Database {
  RealDatabase() {
    print('⏳ جاري الاتصال بقاعدة البيانات...');
  }
  @override
  String query(String sql) => 'نتائج: $sql';
}

class DatabaseProxy implements Database {
  RealDatabase? _db;

  @override
  String query(String sql) {
    // التهيئة الكسولة — الاتصال عند أول استعلام فقط
    _db ??= RealDatabase();
    print('📋 تسجيل الاستعلام: $sql');
    return _db!.query(sql);
  }
}


void main() {
  // --- الاستخدام ---
  final db = DatabaseProxy(); // لم يتصل بعد
  print(db.query('SELECT * FROM users')); // يتصل الآن ثم يُسجِّل ويُنفِّذ
}
```

**متى تستخدمه؟** عند الحاجة للتحميل الكسول (Lazy Loading)، أو التخزين المؤقت (Caching)، أو التحكُّم في الصلاحيات.

---

# ثالثًا: الأنماط السلوكية (Behavioral Patterns)

> تُجيب على سؤال: **كيف تتواصل الكائنات وتتوزَّع المسؤوليات فيما بينها؟**
>
> تهتم بالخوارزميات وتوزيع المهام بين الكائنات بطريقة مرنة وقابلة للتوسُّع.

---

## 13. سلسلة المسؤولية (Chain of Responsibility)

**الوصف:** يُمرِّر الطلب عبر سلسلة من المُعالِجات (Handlers). كل مُعالِج إما يُعالج الطلب أو يُمرِّره للمُعالِج التالي.

**المصطلحات:**
- **المُعالِج (Handler):** الواجهة المشتركة لجميع المُعالِجات
- **الخَلَف (Successor):** المُعالِج التالي في السلسلة

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
    return '❌ لم يتم حل المشكلة: $issue';
  }
}

class BotSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'password_reset') return '🤖 تم إرسال رابط إعادة التعيين';
    return super.handle(issue);
  }
}

class HumanSupport extends SupportHandler {
  @override
  String handle(String issue) {
    if (issue == 'billing') return '👨‍💼 جاري تحويلك لقسم الفوترة';
    return super.handle(issue);
  }
}


void main() {
  // --- الاستخدام ---
  final bot = BotSupport();
  bot.setNext(HumanSupport());

  print(bot.handle('password_reset')); // 🤖 تم إرسال رابط إعادة التعيين
  print(bot.handle('billing'));        // 👨‍💼 جاري تحويلك لقسم الفوترة
  print(bot.handle('unknown'));        // ❌ لم يتم حل المشكلة: unknown
}
```

---

## 14. الأمر (Command)

**الوصف:** يُحوِّل الطلب إلى **كائن مستقل** يحتوي جميع معلومات الطلب. يُتيح تأجيل التنفيذ، والتراجع (Undo)، وتسجيل العمليات.

**المصطلحات:**
- **المُستقبِل (Receiver):** الكائن الذي يُنفِّذ العمل الفعلي
- **المُستدعي (Invoker):** الكائن الذي يُفعِّل الأمر
- **الأمر الفعلي (Concrete Command):** التنفيذ المُحدَّد الذي يربُط المُستدعي بالمُستقبِل

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
  final editor = TextEditor();
  final commands = <Command>[];

  final cmd1 = TypeCommand(editor, 'مرحبًا ');
  final cmd2 = TypeCommand(editor, 'بالعالم!');

  cmd1.execute();
  cmd2.execute();
  commands.addAll([cmd1, cmd2]);
  print(editor.content); // مرحبًا بالعالم!

  commands.removeLast().undo();
  print(editor.content); // مرحبًا
}
```

---

## 15. المُفسِّر (Interpreter)

**الوصف:** يُعرِّف تمثيلًا لقواعد لغة (Grammar) ومُفسِّرًا يستخدم هذا التمثيل لتفسير الجُمل في تلك اللغة.

**المصطلحات:**
- **السياق (Context):** المعلومات المُشتركة أثناء التفسير
- **التعبير النهائي (Terminal Expression):** عنصر أساسي في القواعد
- **التعبير غير النهائي (Non-terminal Expression):** قاعدة مُركَّبة

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
  // --- الاستخدام: x + y ---
  final expression = AddExp(NumberExp('x'), NumberExp('y'));
  print(expression.interpret({'x': 10, 'y': 20})); // 30
}
```

---

## 16. المُكرِّر (Iterator)

**الوصف:** يُوفِّر طريقة للوصول التسلسلي لعناصر مجموعة (Collection) دون كشف بنيتها الداخلية.

**المصطلحات:**
- **المُجمِّع (Aggregate):** المجموعة التي تحتوي العناصر
- **المُكرِّر الفعلي (Concrete Iterator):** التنفيذ الذي يتتبَّع موضع التنقُّل

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
  final playlist = Playlist('المفضلة')
    ..add(Song('Bohemian Rhapsody', 'Queen'))
    ..add(Song('Stairway to Heaven', 'Led Zeppelin'))
    ..add(Song('Hotel California', 'Eagles'));

  print('🎵 ${playlist.name} (${playlist.length} أغاني):');

  final it = playlist.iterator;
  while (it.moveNext()) {
    print('  ▶ ${it.current}');
  }
  // 🎵 المفضلة (3 أغاني):
  //   ▶ Bohemian Rhapsody — Queen
  //   ▶ Stairway to Heaven — Led Zeppelin
  //   ▶ Hotel California — Eagles
}
```

---

## 17. الوسيط (Mediator)

**الوصف:** يُقلِّل الاعتماد المتبادل (Coupling) بين الكائنات بجعلها تتواصل عبر كائن **وسيط** بدلًا من التواصل المباشر.

**المصطلحات:**
- **الزميل (Colleague):** الكائنات التي تتواصل عبر الوسيط
- **الوسيط الفعلي (Concrete Mediator):** التنفيذ الذي يُنسِّق التواصل

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
      print('$name تلقّى من $from: $message');
}


void main() {
  // --- الاستخدام ---
  final room = ChatRoom();
  final ali = User('علي');
  final sara = User('سارة');
  room..register(ali)..register(sara);

  ali.send('مرحبًا!'); // سارة تلقّى من علي: مرحبًا!
}
```

---

## 18. التذكار (Memento)

**الوصف:** يحفظ الحالة الداخلية (State) لكائن في لقطة (Snapshot) حتى يمكن استعادتها لاحقًا دون كسر التغليف (Encapsulation).

**المصطلحات:**
- **المُنشئ (Originator):** الكائن الذي يُنشئ اللقطة ويتم استعادته منها
- **الحارس (Caretaker):** يحفظ اللقطات ويُديرها

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

// --- الحارس ---
class History {
  final _snapshots = <EditorMemento>[];

  void push(EditorMemento memento) => _snapshots.add(memento);
  EditorMemento? pop() => _snapshots.isNotEmpty ? _snapshots.removeLast() : null;
}


void main() {
  // --- الاستخدام ---
  final editor = Editor();
  final history = History();

  editor.content = 'الفصل الأول';
  history.push(editor.save());

  editor.content = 'الفصل الثاني';
  history.push(editor.save());

  editor.content = 'نص خاطئ!';

  editor.restore(history.pop()!);
  print(editor.content); // الفصل الثاني
}
```

---

## 19. المُراقِب (Observer)

**الوصف:** يُعرِّف علاقة **واحد-إلى-كثير** (One-to-Many) بين الكائنات، بحيث عندما يتغيَّر كائن يُخطَر جميع المُعتمِدين عليه تلقائيًا.

**المصطلحات:**
- **الموضوع (Subject):** الكائن المُراقَب الذي يحمل الحالة
- **المُراقِب (Observer):** الكائن الذي يتلقَّى الإشعارات
- **الإخطار (Notify):** عملية إبلاغ المُراقِبين بالتغيير

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
  // --- الاستخدام ---
  final priceTracker = EventEmitter<double>();

  priceTracker.on((price) => print('📊 السعر الجديد: $price'));
  priceTracker.on((price) {
    if (price < 50) print('🔔 تنبيه: السعر منخفض!');
  });

  priceTracker.emit(75.0); // 📊 السعر الجديد: 75.0
  priceTracker.emit(45.0); // 📊 السعر الجديد: 45.0  +  🔔 تنبيه: السعر منخفض!
}
```

---

## 20. الحالة (State)

**الوصف:** يسمح للكائن بتغيير سلوكه عندما تتغيَّر حالته الداخلية. يبدو كأن الكائن غيَّر صنفه.

**المصطلحات:**
- **السياق (Context):** الكائن الذي تتغيَّر حالته
- **الحالة الفعلية (Concrete State):** تنفيذ سلوك حالة مُحدَّدة

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
  String get status => 'قيد الانتظار';
}

class ProcessingState implements OrderState {
  @override
  void next(Order order) => order.state = DeliveredState();
  @override
  String get status => 'قيد المعالجة';
}

class DeliveredState implements OrderState {
  @override
  void next(Order order) => print('الطلب اكتمل بالفعل!');
  @override
  String get status => 'تم التوصيل';
}

class Order {
  OrderState state = PendingState();
  void proceed() => state.next(this);
}


void main() {
  // --- الاستخدام ---
  final order = Order();
  print(order.state.status); // قيد الانتظار
  order.proceed();
  print(order.state.status); // قيد المعالجة
  order.proceed();
  print(order.state.status); // تم التوصيل
}
```

---

## 21. الاستراتيجية (Strategy)

**الوصف:** يُعرِّف عائلة من الخوارزميات، ويضع كلًّا منها في صنف مُنفصل، ويجعلها قابلة للتبديل. يُتيح تغيير الخوارزمية أثناء التشغيل (Runtime).

**المصطلحات:**
- **السياق (Context):** الكائن الذي يستخدم الاستراتيجية
- **الاستراتيجية الفعلية (Concrete Strategy):** تنفيذ خوارزمية مُحدَّدة

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
  // --- الاستخدام ---
  final sorter = Sorter(bubbleSort);
  print(sorter.sort([3, 1, 2])); // [1, 2, 3]

  sorter.strategy = quickSort; // تبديل الاستراتيجية أثناء التشغيل
  print(sorter.sort([9, 5, 7])); // [5, 7, 9]
}
```

---

## 22. أسلوب القالب (Template Method)

**الوصف:** يُحدِّد الهيكل العام (Skeleton) لخوارزمية في الصنف الأب، ويترك بعض الخطوات للأصناف الفرعية لتُعيد تعريفها دون تغيير البنية العامة.

**المصطلحات:**
- **دالّة الخُطّاف (Hook Method):** دالّة اختيارية يُمكن للصنف الفرعي إعادة تعريفها
- **العملية الأوّلية (Primitive Operation):** خطوة إلزامية يجب على الصنف الفرعي تنفيذها

```dart
// DART EXAMPLE

abstract class DataExporter {
  // أسلوب القالب — الهيكل الثابت
  void export() {
    final data = fetchData();
    final formatted = format(data);
    save(formatted);
  }

  List<String> fetchData();     // عملية أوّلية
  String format(List<String> data); // عملية أوّلية
  void save(String output) => print('💾 حفظ: $output'); // خُطّاف
}

class CsvExporter extends DataExporter {
  @override
  List<String> fetchData() => ['اسم', 'عمر', 'مدينة'];

  @override
  String format(List<String> data) => data.join(',');
}

class JsonExporter extends DataExporter {
  @override
  List<String> fetchData() => ['اسم', 'عمر', 'مدينة'];

  @override
  String format(List<String> data) => '{"fields": [${data.map((e) => '"$e"').join(', ')}]}';
}


void main() {
  // --- الاستخدام ---
  CsvExporter().export();  // 💾 حفظ: اسم,عمر,مدينة
  JsonExporter().export(); // 💾 حفظ: {"fields": ["اسم", "عمر", "مدينة"]}
}
```

---

## 23. الزائر (Visitor)

**الوصف:** يفصل **العمليات** عن **بنية الكائنات** التي تعمل عليها. يُتيح إضافة عمليات جديدة دون تعديل أصناف الكائنات.

**المصطلحات:**
- **العنصر (Element):** الكائن الذي يقبل الزائر
- **الزائر الفعلي (Concrete Visitor):** التنفيذ الذي يحتوي المنطق لكل نوع عنصر
- **دالّة القبول (Accept Method):** الدالّة التي يستدعيها العنصر لاستقبال الزائر

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
      print('مساحة الدائرة: ${3.14159 * c.radius * c.radius}');

  @override
  void visitRectangle(Rectangle r) =>
      print('مساحة المستطيل: ${r.width * r.height}');
}


void main() {
  // --- الاستخدام ---
  final shapes = <Shape>[Circle(5), Rectangle(4, 6)];
  final calculator = AreaCalculator();

  for (final shape in shapes) {
    shape.accept(calculator);
  }
  // مساحة الدائرة: 78.53975
  // مساحة المستطيل: 24.0
}
```

---

# 📊 التوزيع النهائي

| الفئة | الاسم بالعربية | العدد |
| :--- | :--- | :---: |
| Creational | الأنماط الإنشائية | 5 |
| Structural | الأنماط البنائية | 7 |
| Behavioral | الأنماط السلوكية | 11 |
| **الإجمالي** | | **23** |

---

# 🧠 الخلاصة

| الفئة | السؤال الذي تُجيب عنه | المثال الأشهر |
| :--- | :--- | :--- |
| **الإنشائية** (Creational) | كيف نُنشئ الكائنات؟ | Singleton, Factory |
| **البنائية** (Structural) | كيف نُركِّب الكائنات؟ | Adapter, Decorator |
| **السلوكية** (Behavioral) | كيف تتواصل الكائنات؟ | Observer, Strategy |