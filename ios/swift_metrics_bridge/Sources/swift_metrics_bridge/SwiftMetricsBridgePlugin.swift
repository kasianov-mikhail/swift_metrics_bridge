#if canImport(CoreMetrics)
import CoreMetrics
import Metrics
#endif
import Flutter
import UIKit

public class SwiftMetricsBridgePlugin: NSObject, FlutterPlugin {
    #if canImport(CoreMetrics)
    private var counters: [String: Counter] = [:]
    private var floatingCounters: [String: FloatingPointCounter] = [:]
    private var timers: [String: CoreMetrics.Timer] = [:]
    #endif

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "swift_metrics_bridge",
            binaryMessenger: registrar.messenger()
        )
        let instance = SwiftMetricsBridgePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "incrementCounter":
            handleIncrementCounter(call, result: result)
        case "incrementFloatingPointCounter":
            handleIncrementFloatingPointCounter(call, result: result)
        case "recordTimer":
            handleRecordTimer(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func handleIncrementCounter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        #if canImport(CoreMetrics)
        guard let args = call.arguments as? [String: Any],
              let label = args["label"] as? String else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing label", details: nil))
            return
        }
        let value = args["value"] as? Int ?? 1
        let counter = getCounter(label: label)
        counter.increment(by: value)
        result(nil)
        #else
        result(FlutterError(code: "UNAVAILABLE", message: "swift-metrics requires Swift Package Manager.", details: nil))
        #endif
    }

    private func handleIncrementFloatingPointCounter(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        #if canImport(CoreMetrics)
        guard let args = call.arguments as? [String: Any],
              let label = args["label"] as? String else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing label", details: nil))
            return
        }
        let value = args["value"] as? Double ?? 1.0
        let counter = getFloatingPointCounter(label: label)
        counter.increment(by: value)
        result(nil)
        #else
        result(FlutterError(code: "UNAVAILABLE", message: "swift-metrics requires Swift Package Manager.", details: nil))
        #endif
    }

    private func handleRecordTimer(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        #if canImport(CoreMetrics)
        guard let args = call.arguments as? [String: Any],
              let label = args["label"] as? String,
              let nanoseconds = args["nanoseconds"] as? Int else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing label or nanoseconds", details: nil))
            return
        }
        let timer = getTimer(label: label)
        timer.recordNanoseconds(Int64(nanoseconds))
        result(nil)
        #else
        result(FlutterError(code: "UNAVAILABLE", message: "swift-metrics requires Swift Package Manager.", details: nil))
        #endif
    }

    #if canImport(CoreMetrics)
    private func getCounter(label: String) -> Counter {
        if let counter = counters[label] {
            return counter
        }
        let counter = Counter(label: label)
        counters[label] = counter
        return counter
    }

    private func getFloatingPointCounter(label: String) -> FloatingPointCounter {
        if let counter = floatingCounters[label] {
            return counter
        }
        let counter = FloatingPointCounter(label: label)
        floatingCounters[label] = counter
        return counter
    }

    private func getTimer(label: String) -> CoreMetrics.Timer {
        if let timer = timers[label] {
            return timer
        }
        let timer = CoreMetrics.Timer(label: label)
        timers[label] = timer
        return timer
    }
    #endif
}
