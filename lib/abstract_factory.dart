/// Demonstrates the **Abstract Factory** pattern.
///
/// Provides an interface for creating families of related objects
/// without specifying their concrete classes.
library;

// --- Abstract Products ---

/// A UI button component.
abstract interface class Button {
  /// Renders this button and returns its visual representation.
  String render();
}

/// A UI text field component.
abstract interface class TextField {
  /// Renders this text field and returns its visual representation.
  String render();
}

// --- Concrete Products ---

/// A Material Design button.
final class MaterialButton implements Button {
  /// Creates a Material Design button.
  const MaterialButton();

  @override
  String render() => '[Material Button]';
}

/// A Cupertino (iOS-style) button.
final class CupertinoButton implements Button {
  /// Creates a Cupertino button.
  const CupertinoButton();

  @override
  String render() => '[Cupertino Button]';
}

/// A Material Design text field.
final class MaterialTextField implements TextField {
  /// Creates a Material Design text field.
  const MaterialTextField();

  @override
  String render() => '[Material TextField]';
}

/// A Cupertino (iOS-style) text field.
final class CupertinoTextField implements TextField {
  /// Creates a Cupertino text field.
  const CupertinoTextField();

  @override
  String render() => '[Cupertino TextField]';
}

// --- Abstract Factory ---

/// Creates a family of related UI widgets.
abstract interface class WidgetFactory {
  /// Creates a [Button] for this platform.
  Button createButton();

  /// Creates a [TextField] for this platform.
  TextField createTextField();
}

// --- Concrete Factories ---

/// Creates Material Design widgets.
final class MaterialFactory implements WidgetFactory {
  /// Creates a Material factory.
  const MaterialFactory();

  @override
  Button createButton() => const MaterialButton();

  @override
  TextField createTextField() => const MaterialTextField();
}

/// Creates Cupertino (iOS-style) widgets.
final class CupertinoFactory implements WidgetFactory {
  /// Creates a Cupertino factory.
  const CupertinoFactory();

  @override
  Button createButton() => const CupertinoButton();

  @override
  TextField createTextField() => const CupertinoTextField();
}

/// Builds a UI using the given [factory].
void buildUI(WidgetFactory factory) {
  final button = factory.createButton();
  final textField = factory.createTextField();
  print(button.render());
  print(textField.render());
}

void main() {
  // CupertinoFactory
  buildUI(const CupertinoFactory());

  // MaterialFactory
  buildUI(const MaterialFactory());
}
