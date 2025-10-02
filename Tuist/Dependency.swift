//
//  Dependency.swift
//  Packages
//
//  Created by JohyeonYoon on 10/3/25.
//

import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: [
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.11.0"))
  ],
  platforms: [.iOS]
)
