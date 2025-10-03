import ProjectDescription

let project = Project(
    name: "App",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.11.0"))
    ],
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "com.jalynneyoon.App",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"],
            dependencies: [
                .project(target: "Home", path: "../Features/Home"),
                .project(target: "Statistics", path: "../Features/Statistics"),
                .project(target: "Data", path: "../Data"),
                .project(target: "DI", path: "../DI"),
            ],
        ),
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.jalynneyoon.AppTests",
            infoPlist: .default,
            sources: ["App/Tests/**"],
            resources: [],
            dependencies: [.target(name: "App")]
        ),
    ]
)
