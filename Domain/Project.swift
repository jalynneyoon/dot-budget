import ProjectDescription

let project = Project(
    name: "Domain",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.11.0"))
    ],
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.jalynneyoon.Domain",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Domain/Sources/**"],
            resources: [],
            dependencies: [
                .package(product: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "DomainTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.jalynneyoon.DomainTests",
            infoPlist: .default,
            sources: ["Domain/Tests/**"],
            dependencies: [.target(name: "Domain")]
        ),
    ]
)