import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'swift_metrics_bridge_method_channel.dart';

abstract class SwiftMetricsBridgePlatform extends PlatformInterface {
  SwiftMetricsBridgePlatform() : super(token: _token);

  static final Object _token = Object();
  static SwiftMetricsBridgePlatform _instance =
      MethodChannelSwiftMetricsBridge();

  static SwiftMetricsBridgePlatform get instance => _instance;

  static set instance(SwiftMetricsBridgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> incrementCounter(String label, {int value = 1}) {
    throw UnimplementedError('incrementCounter() has not been implemented.');
  }

  Future<void> incrementFloatingPointCounter(
    String label, {
    double value = 1.0,
  }) {
    throw UnimplementedError(
      'incrementFloatingPointCounter() has not been implemented.',
    );
  }

  Future<void> recordTimer(String label, {required int nanoseconds}) {
    throw UnimplementedError('recordTimer() has not been implemented.');
  }
}
