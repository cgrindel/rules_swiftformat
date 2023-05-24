// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "rules-swiftformat",
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.51.10"),
    ]
)
