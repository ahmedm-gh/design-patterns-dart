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

  // CupertinoFactory
  buildUI(CupertinoFactory());
}
