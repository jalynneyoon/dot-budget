
//
//  Expense.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public struct Expense {
    public let id: UUID
    public let date: Date
    public let amount: Int
    public let category: Category?
    public let memo: String?
    public let dayKey: Int
    public let monthKey: Int
    public let createdAt: Date
    public let updatedAt: Date

    public init(
        id: UUID,
        date: Date,
        amount: Int,
        category: Category?,
        memo: String?,
        dayKey: Int,
        monthKey: Int,
        createdAt: Date,
        updatedAt: Date
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
