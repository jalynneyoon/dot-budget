//
//  CategoryEntity.swift
//  Database
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import SwiftData

@Model
public final class CategoryEntity {
    @Attribute(.unique) public var id: UUID
    var name: String
    var symbol: String
    var isDefault: Bool
    
    public init(id: UUID = UUID(), name: String, symbol: String, isDefault: Bool = false) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.isDefault = isDefault
    }
}

@Model
public final class AppSettingsEntity {
    @Attribute(.unique) public var id: UUID
    var notificationsEnabled: Bool
    var reminderMinutesFromMidnight: Int
    var currencyCode: String

    public init(
        id: UUID = UUID(),
        notificationsEnabled: Bool,
        reminderMinutesFromMidnight: Int,
        currencyCode: String
    ) {
        self.id = id
        self.notificationsEnabled = notificationsEnabled
        self.reminderMinutesFromMidnight = reminderMinutesFromMidnight
        self.currencyCode = currencyCode
    }
}


/// 키 유틸(집계 최적화)
enum DateKeys {
    static func dayKey(from date: Date, calendar: Calendar = .current) -> Int {
        let comps = calendar.dateComponents([.year, .month, .day], from: date)
        return (comps.year! * 10000) + (comps.month! * 100) + comps.day!
    }
    static func monthKey(from date: Date, calendar: Calendar = .current) -> Int {
        let comps = calendar.dateComponents([.year, .month], from: date)
        return (comps.year! * 100) + comps.month!
    }
}
