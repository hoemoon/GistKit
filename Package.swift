// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GistKit",
    platforms: [
        .macOS(.v10_15), .iOS(.v13),
    ],
    products: [
        .library(
            name: "GistKit",
            targets: ["GistKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/OAuthSwift/OAuthSwift", from: "2.1.0"),
    ],
    targets: [
        .target(
            name: "GistKit",
            dependencies: ["OAuthSwift"]),
        .testTarget(
            name: "GistKitTests",
            dependencies: ["GistKit"]),
    ]
)
