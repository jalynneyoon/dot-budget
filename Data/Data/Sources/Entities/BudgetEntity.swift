//
//  BudgetEntity.swift
//  Data
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import SwiftData

@Model
final class BudgetEntity {
    @Attribute(.unique) var id: UUID
    var monthKey: Int
    var category: CategoryEntity
    var amount: Int

    init(
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
