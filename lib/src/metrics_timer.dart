import '../swift_metrics_bridge_platform_interface.dart';

/// A timer backed by Apple's swift-metrics on iOS.
///
/// Named [MetricsTimer] to avoid conflict with `dart:async` Timer.
class MetricsTimer {
  /// Creates a timer with the given [label].
  const MetricsTimer(this.label);

  /// The label identifying this timer.
  final String label;

  /// Record a [duration].
  Future<void> record(Duration duration) {
    return SwiftMetricsBridgePlatform.instance.recordTimer(
      label,
      nanoseconds: duration.inMicroseconds * 1000,
    );
  }

  /// Record a duration in nanoseconds.
  Future<void> recordNanoseconds(int nanoseconds) {
    return SwiftMetricsBridgePlatform.instance.recordTimer(
      label,
      nanoseconds: nanoseconds,
    );
  }
}
