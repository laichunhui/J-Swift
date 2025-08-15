// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "Packages",
            targets: ["Packages"]),
        .library(name: "JKit", targets: ["JKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.2")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.5.0"),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.21.1"
        ),
        .package(url: "https://github.com/johnpatrickmorgan/FlowStacks.git", from: "0.7.0"),
        .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.3.0"),

    ],
    targets: [
        .target(
            name: "Packages",
            dependencies: [
                .threeComp.tca,
                "JKit",
            ]),
        .target(
            name: "JKit",
            dependencies: [
            ]),
    ]
)

extension Target.Dependency {
    @MainActor
    struct threeComp {
        static let tca = product(
            name: "ComposableArchitecture", package: "swift-composable-architecture")
    }
}
