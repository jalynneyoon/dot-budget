
//
//  DefaultExpenseRepository.swift
//  Data
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import Domain
import SwiftData

public final class DefaultExpenseRepository: ExpenseRepository {
    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func addExpense(_ expense: Domain.Expense) async throws {
        let expenseEntity = expense.toEntity()
        modelContext.insert(expenseEntity)
    }
}
