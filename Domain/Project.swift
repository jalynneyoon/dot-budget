import ProjectDescription

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.jalynneyoon.Domain",
            infoPlist: .default,
            sources: ["Domain/Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "Shared", path: "../Shared"),
                .project(target: "CoreTCA", path: "../Core/CoreTCA"),
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
