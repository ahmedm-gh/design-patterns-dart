/// Demonstrates the **Service Locator** pattern.
///
/// A central registry that provides global access to services.
/// An alternative to Dependency Injection for simpler setups.
library;

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
  // --- 📍 مُحدِّد الخدمات
  print('Service Locator ---');
  final locator = ServiceLocator();

  // تسجيل | Register
  // تسجيل خدمة Firebase...
  print('Registering Firebase service...');
  locator.register<AnalyticsService>(FirebaseAnalytics());

  // استرجاع من أي مكان | Retrieve from anywhere
  // استرجاع الخدمة وتتبع حدث...
  print('Retrieving service and tracking...');
  locator.get<AnalyticsService>().track('page_view');

  // --- للاختبار
  print('For Testing ---');
  // للاختبار: تبديل التنفيذ | For testing: swap
  // تبديل التنفيذ إلى خدمة وهمية...
  print('Swapping to fake service...');
  locator.reset();
  locator.register<AnalyticsService>(FakeAnalytics());
  locator.get<AnalyticsService>().track('page_view');
}
