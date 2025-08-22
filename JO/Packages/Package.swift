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
        .library(name: "JNetwork", targets: ["JNetwork"]),
        .library(name: "JResources", targets: ["JResources"]),
        .library(name: "JUI", targets: ["JUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.2")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.5.0"),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.21.1"
        ),
        .package(url: "https://github.com/johnpatrickmorgan/FlowStacks.git", from: "0.7.0"),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack", from: "3.9.0"),
        .package(url: "https://github.com/mac-cain13/R.swift.git", from: "7.0.0"),
        // UI --
        .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.3.0"),
        .package(url: "https://github.com/CoderMJLee/MJRefresh.git", from: "3.7.9"),
        // -- UI

    ],
    targets: [
        .target(
            name: "Packages",
            dependencies: [
                .threeComp.tca,
                "JKit",
                "JNetwork"
            ]),
        .target(
            name: "JKit",
            dependencies: [
                .threeComp.logger
            ]),
        .target(
            name: "JNetwork",
            dependencies: [
                "JKit",
                .threeComp.alamofire,
                .threeComp.tca,
            ]),
        .target(
            name: "JResources",
            dependencies: [],
            resources: [
                .process("Resources"),
            ],
            plugins: [.plugin(name: "RswiftGeneratePublicResources", package: "R.swift")]
            ),
        .target(
            name: "JUI",
            dependencies: [
                "JKit",
                "JResources",
//                .threeComp.kingfisher,
//                .threeComp.zipArchive,
                .threeComp.swiftUIIntrospect,
                .threeComp.RSwift,
                .threeComp.mjRefresh,
//                .threeComp.sdWebImageSwiftUI,
//                .threeComp.sdWebImageWebPCoder
            ],
            plugins: [.plugin(name: "RswiftGeneratePublicResources", package: "R.swift")]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension Target.Dependency {
    @MainActor
    struct threeComp {
        static let tca = product(
            name: "ComposableArchitecture", package: "swift-composable-architecture")
        static let logger = product(
            name: "CocoaLumberjackSwift", package: "CocoaLumberjack")
        static let alamofire = byName(name: "Alamofire")
        static let RSwift = product(name: "RswiftLibrary", package: "R.swift")
        static let mjRefresh = product(name: "MJRefresh", package: "MJRefresh")
        static let swiftUIIntrospect = product(name: "SwiftUIIntrospect", package: "swiftui-introspect")
    }
}
