
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CoreTCA",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.11.0"))
    ],
    targets: [
        .target(
            name: "CoreTCA",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.jalynneyoon.CoreTCA",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "ComposableArchitecture"),
                .package(product: "Dependencies"),
                .package(product: "CasePaths"),
                .package(product: "Perception"),
            ]
        ),
    ]
)
