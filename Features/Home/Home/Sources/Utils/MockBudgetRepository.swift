
//
//  MockBudgetRepository.swift
//  Home
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation
import Domain

final class MockBudgetRepository: BudgetRepository {
    var budgets: [Budget]

    init(initialBudgets: [Budget] = []) {
        self.budgets = initialBudgets
    }

    func setBudget(_ budget: Budget) throws {
        if let index = budgets.firstIndex(where: { $0.monthKey == budget.monthKey && $0.category == budget.category }) {
            budgets[index] = budget
        } else {
            budgets.append(budget)
        }
    }

    func getBudgets(for monthKey: Int) throws -> [Budget] {
        return budgets.filter { $0.monthKey == monthKey }
    }
}
