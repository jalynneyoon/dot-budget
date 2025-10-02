
import ProjectDescription

let project = Project(
    name: "Statistics",
    targets: [
        .target(
            name: "Statistics",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.jalynneyoon.Statistics",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Statistics/Sources/**"],
            resources: ["Statistics/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "StatisticsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.StatisticsTests",
            infoPlist: .default,
            sources: ["Statistics/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Statistics")]
        ),
    ]
)
