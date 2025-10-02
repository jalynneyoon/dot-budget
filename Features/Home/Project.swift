import ProjectDescription

let project = Project(
    name: "Home",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.11.0"))
    ],
    targets: [
        .target(
            name: "Home",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.jalynneyoon.Home",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Home/Sources/**"],
            resources: ["Home/Resources/**"],
            dependencies: [
                .package(product: "ComposableArchitecture"),
                .package(product: "Dependencies"),
                .package(product: "CasePaths"),
                .package(product: "Perception"),
                .project(target: "Domain", path: "../../Domain"),
                
            ]
        ),
        .target(
            name: "HomeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.HomeTests",
            infoPlist: .default,
            sources: ["Home/Tests/**"],
            dependencies: [.target(name: "Home")]
        ),
    ]
)
