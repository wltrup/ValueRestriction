// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ValueRestriction",
    platforms: [
        .iOS(.v10),
        .watchOS(.v4),
        .tvOS(.v10),
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "ValueRestriction",
            targets: ["ValueRestriction"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ValueRestriction",
            dependencies: []),
        .testTarget(
            name: "ValueRestrictionTests",
            dependencies: ["ValueRestriction"]),
    ]
)
