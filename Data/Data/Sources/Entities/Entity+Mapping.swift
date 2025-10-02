
//
//  Entity+Mapping.swift
//  Data
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import Domain

// MARK: - Category

extension CategoryEntity {
    func toDomain() -> Domain.Category {
        return Domain.Category(
            id: self.id,
            name: self.name,
            symbol: self.symbol,
            isDefault: self.isDefault
        )
    }
}

// MARK: - Budget

extension BudgetEntity {
    func toDomain() -> Domain.Budget {
        return Domain.Budget(
            id: self.id,
            monthKey: self.monthKey,
            category: self.category.toDomain(),
            amount: self.amount
        )
    }
}

// MARK: - Expense

extension ExpenseEntity {
    func toDomain() -> Domain.Expense {
        return Domain.Expense(
            id: self.id,
            date: self.date,
            amount: self.amount,
            category: self.category?.toDomain(),
            memo: self.memo,
            dayKey: self.dayKey,
            monthKey: self.monthKey,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
}

// MARK: - BadgeUnlock

extension BadgeUnlockEntity {
    func toDomain() -> Domain.BadgeUnlock? {
        guard let badgeType = Domain.BadgeType(rawValue: self.typeRaw) else {
            // Handle error case, maybe log it
            print("Unknown badge type raw value: \(self.typeRaw)")
            return nil
        }
        
        return Domain.BadgeUnlock(
            id: self.id,
            type: badgeType,
            unlockedAt: self.unlockedAt
        )
    }
}

// MARK: - AppSettings

extension AppSettingsEntity {
    func toDomain() -> Domain.AppSettings {
        return Domain.AppSettings(
            id: self.id,
            notificationsEnabled: self.notificationsEnabled,
            reminderMinutesFromMidnight: self.reminderMinutesFromMidnight,
            currencyCode: self.currencyCode
        )
    }
}

