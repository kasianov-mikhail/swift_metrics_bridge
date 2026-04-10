import 'package:flutter/material.dart';
import 'package:swift_metrics_bridge/swift_metrics_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('swift-metrics Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  const counter = Counter('button_taps');
                  counter.increment();
                },
                child: const Text('Increment Counter'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  const timer = MetricsTimer('operation');
                  timer.record(const Duration(milliseconds: 150));
                },
                child: const Text('Record Timer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
