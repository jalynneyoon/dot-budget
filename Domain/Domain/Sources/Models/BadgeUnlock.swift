
//
//  BadgeUnlock.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public enum BadgeType: String, CaseIterable {
    case firstExpense
    case budgetTracker
    case savingsChampion
    case consistentSpender
    case debtFree
    case investmentMaster
    case emergencyFunded
    case mindfulSpender
    case travelSaver
    case techGadgeteer
    
    // TODO: Add more badge types as needed
}

public struct BadgeUnlock {
    public let id: UUID
    public let type: BadgeType
    public let unlockedAt: Date
    
    public init(id: UUID, type: BadgeType, unlockedAt: Date) {
        self.id = id
        self.type = type
        self.unlockedAt = unlockedAt
    }
}
