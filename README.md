<div align="center">

# 🎯 أنماط التصميم في دارت | Design Patterns in Dart

### الأنماط الثلاثة والعشرون (GoF) — بأمثلة دارت عملية
### The 23 Gang of Four (GoF) Patterns — with Practical Dart Examples

[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

**[📖 الشرح الكامل | Full Documentation](design_patterns_bilingual.md)**

</div>

---

## 📖 عن المشروع | About

مرجع شامل لجميع **23 نمط تصميم GoF**، كل نمط مشروح بـ:

A comprehensive reference for all **23 GoF Design Patterns**, each explained with:

- ✅ وصف واضح للنمط والمشكلة التي يحُلّها | Clear description of the pattern and its problem
- ✅ المصطلحات بالعربية والإنجليزية | Key terminology in Arabic and English
- ✅ أمثلة **Dart** عملية وقابلة للتشغيل | Practical, runnable **Dart** code examples
- ✅ إرشادات "متى تستخدمه؟" | "When to use?" guidance
- ✅ يتبع [Effective Dart](https://dart.dev/effective-dart) best practices

> سواء كنت تستعد لمقابلات العمل، أو تتعلم البرمجة الكائنية، أو تبني تطبيقات Flutter/Dart — هذا المرجع يُغطّيك.
>
> Whether you're preparing for interviews, learning OOP, or building Flutter/Dart apps — this repo has you covered.

---

## 🏗️ الأنماط | Patterns Overview

### الأنماط الإنشائية — *كيف نُنشئ الكائنات؟*
### Creational Patterns — *How do we create objects?*

| # | النمط | Pattern | الوصف — Description |
|---|-------|---------|---------------------|
| 1 | [**المصنع المُجرَّد**](design_patterns_bilingual.md#abstract-factory) | Abstract Factory | إنشاء عائلة كائنات مترابطة — Create families of related objects |
| 2 | [**الباني**](design_patterns_bilingual.md#builder) | Builder | بناء كائنات مُعقَّدة خطوة بخطوة — Construct complex objects step by step |
| 3 | [**دالّة المصنع**](design_patterns_bilingual.md#factory-method) | Factory Method | ترك قرار الإنشاء للأصناف الفرعية — Let subclasses decide which class to instantiate |
| 4 | [**النموذج الأوَّلي**](design_patterns_bilingual.md#prototype) | Prototype | نسخ كائنات بدلًا من البناء من الصفر — Clone objects instead of building from scratch |
| 5 | [**الكائن الوحيد**](design_patterns_bilingual.md#singleton) | Singleton | ضمان نسخة واحدة فقط — Ensure a single instance globally |

### الأنماط البنائية — *كيف نُركِّب الكائنات؟*
### Structural Patterns — *How do we compose objects?*

| # | النمط | Pattern | الوصف — Description |
|---|-------|---------|---------------------|
| 6 | [**المُحوِّل**](design_patterns_bilingual.md#adapter) | Adapter | جسر توافق بين واجهتين — Bridge between incompatible interfaces |
| 7 | [**الجسر**](design_patterns_bilingual.md#bridge) | Bridge | فصل التجريد عن التنفيذ — Decouple abstraction from implementation |
| 8 | [**المُركَّب**](design_patterns_bilingual.md#composite) | Composite | التعامل مع بنى شجرية — Treat individual/groups uniformly (tree) |
| 9 | [**المُزخرِف**](design_patterns_bilingual.md#decorator) | Decorator | إضافة مسؤوليات ديناميكيًا — Add responsibilities dynamically |
| 10 | [**الواجهة المُبسَّطة**](design_patterns_bilingual.md#facade) | Facade | تبسيط نظام فرعي مُعقَّد — Simplified interface to a complex subsystem |
| 11 | [**وزن الذبابة**](design_patterns_bilingual.md#flyweight) | Flyweight | مشاركة البيانات لتقليل الذاكرة — Share data to reduce memory |
| 12 | [**الوكيل**](design_patterns_bilingual.md#proxy) | Proxy | التحكم في الوصول لكائن آخر — Control access to another object |

### الأنماط السلوكية — *كيف تتواصل الكائنات؟*
### Behavioral Patterns — *How do objects communicate?*

| # | النمط | Pattern | الوصف — Description |
|---|-------|---------|---------------------|
| 13 | [**سلسلة المسؤولية**](design_patterns_bilingual.md#chain-of-responsibility) | Chain of Responsibility | تمرير الطلبات عبر سلسلة — Pass requests along a chain |
| 14 | [**الأمر**](design_patterns_bilingual.md#command) | Command | تغليف الطلبات ككائنات — Encapsulate requests as objects |
| 15 | [**المُفسِّر**](design_patterns_bilingual.md#interpreter) | Interpreter | تعريف قواعد لغة وتفسيرها — Define grammar and interpret sentences |
| 16 | [**المُكرِّر**](design_patterns_bilingual.md#iterator) | Iterator | الوصول التسلسلي للعناصر — Access elements sequentially |
| 17 | [**الوسيط**](design_patterns_bilingual.md#mediator) | Mediator | تقليل الاقتران عبر وسيط — Reduce coupling via a mediator |
| 18 | [**التذكار**](design_patterns_bilingual.md#memento) | Memento | حفظ واستعادة الحالة — Capture and restore state |
| 19 | [**المُراقِب**](design_patterns_bilingual.md#observer) | Observer | إخطار تلقائي عند تغيُّر الحالة — Auto-notify on state changes |
| 20 | [**الحالة**](design_patterns_bilingual.md#state) | State | تغيير السلوك حسب الحالة — Change behavior based on state |
| 21 | [**الاستراتيجية**](design_patterns_bilingual.md#strategy) | Strategy | تبديل الخوارزميات أثناء التشغيل — Swap algorithms at runtime |
| 22 | [**أسلوب القالب**](design_patterns_bilingual.md#template-method) | Template Method | هيكل ثابت مع خطوات قابلة للتخصيص — Fixed skeleton, customizable steps |
| 23 | [**الزائر**](design_patterns_bilingual.md#visitor) | Visitor | فصل العمليات عن بنية الكائنات — Separate operations from structure |

---

## 🚀 البداية السريعة | Quick Start

كل نمط له ملف Dart مستقل في `lib/` يمكنك تشغيله مباشرة:

Each pattern has a standalone Dart file in `lib/` you can run directly:

```bash
dart run lib/singleton.dart
dart run lib/observer.dart
dart run lib/builder.dart
# ... etc.
```

---

## 📊 الملخص | Summary

| الفئة — Category | العدد — Count |
|-------------------|:---:|
| الإنشائية — Creational | 5 |
| البنائية — Structural | 7 |
| السلوكية — Behavioral | 11 |
| **الإجمالي — Total** | **23** |

---

## ✅ Effective Dart

يتبع هذا المشروع إرشادات [Effective Dart](https://dart.dev/effective-dart):

This project follows [Effective Dart](https://dart.dev/effective-dart) guidelines:

- 📏 **Style**: `final class`, `interface class`, `const` constructors
- 📝 **Documentation**: `///` doc comments for all public APIs
- 🔧 **Usage**: initializing formals, `=>` for simple members, `const` where possible
- 🏛️ **Design**: class modifiers, `final` fields, `sealed`/`interface` types

---

## 🤝 المساهمة | Contributing

المساهمات والمقترحات مرحّب بها! لا تتردد في فتح PR أو issue.

Contributions, issues, and feature requests are welcome! Feel free to open a PR or issue.

---

## 📄 الرخصة | License

هذا المشروع مُرخَّص تحت [رخصة MIT](LICENSE).

This project is licensed under the [MIT License](LICENSE).

---

<div align="center">

**⭐ إذا وجدته مفيدًا، لا تنسَ النجمة! | If you found this helpful, give it a star! ⭐**

</div>
