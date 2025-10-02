//
//  BudgetEntity.swift
//  Data
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import SwiftData

@Model
public final class BudgetEntity {
    @Attribute(.unique) public var id: UUID
    var monthKey: Int
    var category: CategoryEntity
    var amount: Int

    public init(
        id: UUID = UUID(),
        monthKey: Int,
        category: CategoryEntity,
        amount: Int
    ) {
        self.id = id
        self.monthKey = monthKey
        self.category = category
        self.amount = amount
    }
}
