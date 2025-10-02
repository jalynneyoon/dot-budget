
//
//  AppSettings.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public struct AppSettings {
    public let id: UUID
    public let notificationsEnabled: Bool
    public let reminderMinutesFromMidnight: Int
    public let currencyCode: String

    public init(
        id: UUID,
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
