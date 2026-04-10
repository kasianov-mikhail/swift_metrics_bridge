import '../swift_metrics_bridge_platform_interface.dart';

/// A floating-point counter backed by Apple's swift-metrics on iOS.
class FloatingPointCounter {
  /// Creates a floating-point counter with the given [label].
  const FloatingPointCounter(this.label);

  /// The label identifying this counter.
  final String label;

  /// Increment the counter by [value] (default 1.0).
  Future<void> increment({double value = 1.0}) {
    return SwiftMetricsBridgePlatform.instance.incrementFloatingPointCounter(
      label,
      value: value,
    );
  }
}
