import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'swift_metrics_bridge_platform_interface.dart';

class MethodChannelSwiftMetricsBridge extends SwiftMetricsBridgePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('swift_metrics_bridge');

  @override
  Future<void> incrementCounter(String label, {int value = 1}) async {
    await methodChannel.invokeMethod('incrementCounter', {
      'label': label,
      'value': value,
    });
  }

  @override
  Future<void> incrementFloatingPointCounter(
    String label, {
    double value = 1.0,
  }) async {
    await methodChannel.invokeMethod('incrementFloatingPointCounter', {
      'label': label,
      'value': value,
    });
  }

  @override
  Future<void> recordTimer(String label, {required int nanoseconds}) async {
    await methodChannel.invokeMethod('recordTimer', {
      'label': label,
      'nanoseconds': nanoseconds,
    });
  }
}
