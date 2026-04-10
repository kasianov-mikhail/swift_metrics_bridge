// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swift_metrics_bridge",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "swift-metrics-bridge", targets: ["swift_metrics_bridge"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-metrics.git", "1.0.0" ..< "3.0.0"),
    ],
    targets: [
        .target(
            name: "swift_metrics_bridge",
            dependencies: [
                .product(name: "Metrics", package: "swift-metrics"),
            ]
        )
    ]
)
