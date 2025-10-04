import ProjectDescription

let project = Project(
    name: "Shared",
    targets: [
        .target(
            name: "Shared",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.jalynneyoon.Shared",
            infoPlist: .default,
            sources: ["Shared/Sources/**"],
            dependencies: []
        ),
        .target(
            name: "SharedTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.jalynneyoon.SharedTests",
            infoPlist: .default,
            sources: ["Shared/Tests/**"],
            dependencies: [.target(name: "Shared")]
        ),
    ]
)
