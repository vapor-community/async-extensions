// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "AsyncExtensions",
    products: [
        .library(name: "AsyncExtensions", targets: ["AsyncExtensions"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/async.git", from: "1.0.0-rc")
    ],
    targets: [
        .target(name: "AsyncExtensions", dependencies: ["Async"]),
        .testTarget(name: "AsyncExtensionsTests", dependencies: ["AsyncExtensions"])
    ]
)
