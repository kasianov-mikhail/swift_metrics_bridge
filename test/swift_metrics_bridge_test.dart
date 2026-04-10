import 'package:flutter_test/flutter_test.dart';
import 'package:swift_metrics_bridge/swift_metrics_bridge.dart';
import 'package:swift_metrics_bridge/swift_metrics_bridge_platform_interface.dart';
import 'package:swift_metrics_bridge/swift_metrics_bridge_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSwiftMetricsBridgePlatform
    with MockPlatformInterfaceMixin
    implements SwiftMetricsBridgePlatform {
  String? lastLabel;
  int? lastIntValue;
  double? lastDoubleValue;
  int? lastNanoseconds;

  @override
  Future<void> incrementCounter(String label, {int value = 1}) async {
    lastLabel = label;
    lastIntValue = value;
  }

  @override
  Future<void> incrementFloatingPointCounter(
    String label, {
    double value = 1.0,
  }) async {
    lastLabel = label;
    lastDoubleValue = value;
  }

  @override
  Future<void> recordTimer(String label, {required int nanoseconds}) async {
    lastLabel = label;
    lastNanoseconds = nanoseconds;
  }
}

void main() {
  final SwiftMetricsBridgePlatform initialPlatform =
      SwiftMetricsBridgePlatform.instance;

  test('MethodChannelSwiftMetricsBridge is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSwiftMetricsBridge>());
  });

  test('Counter.increment delegates to platform', () async {
    final mock = MockSwiftMetricsBridgePlatform();
    SwiftMetricsBridgePlatform.instance = mock;

    const counter = Counter('button_taps');
    await counter.increment(value: 3);

    expect(mock.lastLabel, 'button_taps');
    expect(mock.lastIntValue, 3);
  });

  test('FloatingPointCounter.increment delegates to platform', () async {
    final mock = MockSwiftMetricsBridgePlatform();
    SwiftMetricsBridgePlatform.instance = mock;

    const counter = FloatingPointCounter('revenue');
    await counter.increment(value: 9.99);

    expect(mock.lastLabel, 'revenue');
    expect(mock.lastDoubleValue, 9.99);
  });

  test('MetricsTimer.record delegates to platform', () async {
    final mock = MockSwiftMetricsBridgePlatform();
    SwiftMetricsBridgePlatform.instance = mock;

    const timer = MetricsTimer('api_latency');
    await timer.record(const Duration(milliseconds: 250));

    expect(mock.lastLabel, 'api_latency');
    expect(mock.lastNanoseconds, 250000000);
  });

  test('MetricsTimer.recordNanoseconds delegates to platform', () async {
    final mock = MockSwiftMetricsBridgePlatform();
    SwiftMetricsBridgePlatform.instance = mock;

    const timer = MetricsTimer('fast_op');
    await timer.recordNanoseconds(1500);

    expect(mock.lastLabel, 'fast_op');
    expect(mock.lastNanoseconds, 1500);
  });
}
