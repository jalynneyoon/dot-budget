import ProjectDescription

let project = Project(
    name: "Home",
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
            dependencies: []
        ),
        .target(
            name: "HomeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.HomeTests",
            infoPlist: .default,
            sources: ["Home/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Home")]
        ),
    ]
)
