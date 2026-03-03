/// Demonstrates the **Abstract Factory** pattern.
///
/// Provides an interface for creating families of related objects
/// without specifying their concrete classes.
library;

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

// --- الاستخدام ---
// --- Usage ---
void buildUI(WidgetFactory factory) {
  print('--- 🛠️ بناء واجهة المستخدم | Building UI ---');
  final button = factory.createButton();
  final textField = factory.createTextField();
  print('🔘 ${button.render()}');
  print('📝 ${textField.render()}');
}

void main() {
  print('🍎 استخدام مصنع آبل | Using CupertinoFactory:');
  buildUI(CupertinoFactory());

  print('\n🤖 استخدام مصنع جوجل | Using MaterialFactory:');
  buildUI(MaterialFactory());
}
