//import ProjectDescription
//
//public enum Module {
//    case app
//    case framework
//    case unitTest(target: String)
//
//    var product: Product {
//        switch self {
//        case .app: return .app
//        case .framework: return .framework
//        case .unitTest: return .unitTests
//        }
//    }
//}
//
//public extension Project {
//    static func make(
//        name: String,
//        targets: [Target],
//        packages: [Package] = []
//    ) -> Project {
//        .init(
//            name: name,
//            packages: packages,
//            targets: targets
//        )
//    }
//
//    static func frameworkTargets(
//        name: String,
//        dependencies: [TargetDependency] = [],
//        bundleId: String
//    ) -> [Target] {
//        let main = Target(
//            name: name,
//            platform: .iOS,
//            product: .framework,
//            bundleId: bundleId,
//            deploymentTarget: .iOS(targetVersion: "18.0", devices: [.iphone]),
//            infoPlist: .default,
//            sources: ["Sources/**"],
//            resources: ["Resources/**"],
//            dependencies: dependencies
//        )
//
//        let tests = Target(
//            name: "\(name)Tests",
//            platform: .iOS,
//            product: .unitTests,
//            bundleId: "\(bundleId).tests",
//            infoPlist: .default,
//            sources: ["Tests/**"],
//            dependencies: [.target(name: name)]
//        )
//
//        return [main, tests]
//    }
//
//    static func appTarget(
//        name: String,
//        bundleId: String,
//        dependencies: [TargetDependency]
//    ) -> Target {
//        Target(
//            name: name,
//            platform: .iOS,
//            product: .app,
//            bundleId: bundleId,
//            deploymentTarget: .iOS(targetVersion: "18.0", devices: [.iphone]),
//            infoPlist: .extendingDefault(with: [
//                "UILaunchScreen": [:]
//            ]),
//            sources: ["Sources/**"],
//            resources: ["Resources/**"],
//            entitlements: nil,
//            dependencies: dependencies
//        )
//    }
//}
