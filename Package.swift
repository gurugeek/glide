// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SwiftExpress",
    platforms: [
      .macOS(.v10_15)
    ],
    products: [
      .library(name: "SwiftExpress", targets: ["SwiftExpress"]),
      .executable(name: "sample", targets: ["Sample"])
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-nio", from: "2.12.0"),
      .package(url: "https://github.com/vapor-community/HTMLKit.git", from: "2.0.0-beta.1"),
      .package(url: "https://github.com/OpenKitten/MongoKitten.git", from: "6.0.0")
  ],
    targets: [
      .target(
        name: "Sample",
        dependencies: ["SwiftExpress", "MongoKitten", "Meow"]
      ),
      .target(
        name: "SwiftExpress",
        dependencies: [
          "NIO",
          "NIOFoundationCompat",
          "NIOHTTP1",
          "NIOTLS",
          "HTMLKit"
      ]),
      .testTarget(
        name: "SwiftExpressTests",
        dependencies: ["SwiftExpress"]),
  ]
)

