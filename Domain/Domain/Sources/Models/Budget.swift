
//
//  Budget.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public struct Budget: Equatable {
    public let id: UUID
    public let monthKey: Int
    public let category: Category
    public let amount: Int

    public init(
        id: UUID,
        monthKey: Int,
        category: Category,
        amount: Int
    ) {
        self.id = id
        self.monthKey = monthKey
        self.category = category
        self.amount = amount
    }
}
