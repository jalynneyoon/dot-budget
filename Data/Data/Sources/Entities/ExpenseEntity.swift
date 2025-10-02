//
//  ExpenseEntity.swift
//  Data
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import SwiftData

@Model
final class ExpenseEntity {
    @Attribute(.unique) var id: UUID
    var date: Date
    var amount: Int
    var category: CategoryEntity?
    var memo: String?
    var dayKey: Int
    var monthKey: Int
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        date: Date,
        amount: Int,
        category: CategoryEntity? = nil,
        memo: String? = nil,
        dayKey: Int,
        monthKey: Int,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.date = date
        self.amount = amount
        self.category = category
        self.memo = memo
        self.dayKey = dayKey
        self.monthKey = monthKey
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
