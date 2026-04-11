<div align="center">

# Swift Metrics Bridge

**Flutter bridge to Apple's [swift-metrics](https://github.com/apple/swift-metrics)**

[![CI](https://github.com/kasianov-mikhail/swift_metrics_bridge/actions/workflows/ci.yml/badge.svg)](https://github.com/kasianov-mikhail/swift_metrics_bridge/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/swift_metrics_bridge.svg)](https://pub.dev/packages/swift_metrics_bridge)
[![license](https://img.shields.io/github/license/kasianov-mikhail/swift_metrics_bridge.svg)](https://github.com/kasianov-mikhail/swift_metrics_bridge/blob/main/LICENSE)

Counter · FloatingPointCounter · Timer

</div>

<br>

> [!NOTE]
> iOS only.

## Installation

```yaml
dependencies:
  swift_metrics_bridge: ^0.1.0
```

## Usage

```dart
import 'package:swift_metrics_bridge/swift_metrics_bridge.dart';

// Integer counter
const counter = Counter('button_taps');
await counter.increment();
await counter.increment(value: 5);

// Floating-point counter
const revenue = FloatingPointCounter('revenue');
await revenue.increment(value: 9.99);

// Timer
const timer = MetricsTimer('api_latency');
await timer.record(Duration(milliseconds: 250));
await timer.recordNanoseconds(1500);
```

## How It Works

Each metric instance maps to a corresponding swift-metrics type on iOS via method channels. By default, swift-metrics uses a no-op backend — configure a backend like [Scout](https://github.com/kasianov-mikhail/scout) on the iOS side to persist metrics.
