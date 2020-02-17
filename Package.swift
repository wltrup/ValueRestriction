// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ValueRestriction",
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
