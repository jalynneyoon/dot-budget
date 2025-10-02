import ProjectDescription

let project = Project(
    name: "DI",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.11.0"))
    ],
    targets: [
        .target(
            name: "DI",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.jalynneyoon.DI",
            infoPlist: .default,
            sources: ["DI/Sources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .package(product: "ComposableArchitecture"),
                .package(product: "Dependencies"),
                .package(product: "CasePaths"),
                .package(product: "Perception"),
            ]
        ),
        .target(
            name: "DITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.jalynneyoon.DITests",
            infoPlist: .default,
            sources: ["DI/Tests/**"],
            dependencies: [.target(name: "DI")]
        ),
    ]
)
