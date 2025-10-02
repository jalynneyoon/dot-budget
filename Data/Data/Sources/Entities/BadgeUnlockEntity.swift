//
//  BadgeUnlockEntity.swift
//  Data
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import SwiftData

@Model
final class BadgeUnlockEntity {
    @Attribute(.unique) var id: UUID
    var typeRaw: String
    var unlockedAt: Date

    init(
        id: UUID = UUID(),
        typeRaw: String,
        unlockedAt: Date
    ) {
        self.id = id
        self.typeRaw = typeRaw
        self.unlockedAt = unlockedAt
    }
}
