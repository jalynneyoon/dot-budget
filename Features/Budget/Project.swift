
import ProjectDescription

let project = Project(
    name: "Budget",
    targets: [
        .target(
            name: "Budget",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.jalynneyoon.Budget",
            infoPlist: .default,
            sources: ["Budget/Sources/**"],
            resources: ["Budget/Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../../Domain"),
                .project(target: "CoreTCA", path: "../../Core/CoreTCA"),
            ]
        ),
        .target(
            name: "BudgetTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.jalynneyoon.BudgetTests",
            infoPlist: .default,
            sources: ["Budget/Tests/**"],
            dependencies: [.target(name: "Budget")]
        ),
    ]
)
