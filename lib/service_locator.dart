/// Demonstrates the **Service Locator** pattern.
///
/// A central registry that provides global access to services.
/// An alternative to Dependency Injection for simpler setups.
library;

/// A central registry for locating services by type.
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  final _factories = <Type, Object Function()>{};
  final _singletons = <Type, Object>{};

  ServiceLocator._internal();

  /// Returns the global [ServiceLocator] instance.
  factory ServiceLocator() => _instance;

  /// Registers a factory that creates a new instance each time.
  void register<T extends Object>(T Function() factory) {
    _factories[T] = factory;
  }

  /// Registers a single instance (singleton).
  void registerSingleton<T extends Object>(T instance) {
    _singletons[T] = instance;
  }

  /// Retrieves a service of type [T].
  ///
  /// Throws [StateError] if no service of type [T] is registered.
  T get<T extends Object>() {
    if (_singletons.containsKey(T)) return _singletons[T] as T;
    final factory = _factories[T];
    if (factory != null) return factory() as T;
    throw StateError('Service not registered: $T');
  }

  /// Removes all registered services (useful for testing).
  void reset() {
    _factories.clear();
    _singletons.clear();
  }
}

// --- Usage Example ---

/// An analytics service interface.
abstract interface class AnalyticsService {
  /// Tracks an event with the given [name].
  void track(String name);
}

/// A real analytics service.
final class FirebaseAnalytics implements AnalyticsService {
  @override
  void track(String name) => print('🔥 Firebase: $name');
}

/// A fake analytics service for testing.
final class FakeAnalytics implements AnalyticsService {
  @override
  void track(String name) => print('🧪 Fake: $name');
}

void main() {
  final locator = ServiceLocator();

  // Register services
  locator.registerSingleton<AnalyticsService>(FirebaseAnalytics());

  // Retrieve from anywhere in the app
  final analytics = locator.get<AnalyticsService>();
  analytics.track('page_view'); // 🔥 Firebase: page_view

  // For testing: swap implementation
  locator.reset();
  locator.registerSingleton<AnalyticsService>(FakeAnalytics());

  final testAnalytics = locator.get<AnalyticsService>();
  testAnalytics.track('page_view'); // 🧪 Fake: page_view
}
