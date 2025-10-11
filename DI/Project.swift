import ProjectDescription

let project = Project(
    name: "DI",
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
                .project(target: "Data", path: "../Data"),
                .project(target: "CoreTCA", path: "../Core/CoreTCA"),
            ]
        ),
    ]
)
