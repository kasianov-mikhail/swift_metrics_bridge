import '../swift_metrics_bridge_platform_interface.dart';

/// An integer counter backed by Apple's swift-metrics on iOS.
class Counter {
  /// Creates a counter with the given [label].
  const Counter(this.label);

  /// The label identifying this counter.
  final String label;

  /// Increment the counter by [value] (default 1).
  Future<void> increment({int value = 1}) {
    return SwiftMetricsBridgePlatform.instance.incrementCounter(
      label,
      value: value,
    );
  }
}
