//
//  GetMonthlySummaryUseCase.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import Shared

public final class GetMonthlySummaryUseCase {
    private let expenseRepository: ExpenseRepository
    private let budgetRepository: BudgetRepository

    public init(expenseRepository: ExpenseRepository, budgetRepository: BudgetRepository) {
        self.expenseRepository = expenseRepository
        self.budgetRepository = budgetRepository
    }

    public func execute(for date: Date) async throws -> MonthlySummary {
        let calendar = Calendar.current
        let monthKey = DateKeys.monthKey(from: date, calendar: calendar)
        
        // Data
        let budgets = try budgetRepository.getBudgets(for: monthKey)
        let expenses = try await expenseRepository.getMonthlyExpenses(for: date)
        
        let totalBudget = budgets.reduce(0) { $0 + $1.amount }
        let totalExpense = expenses.reduce(0) { $0 + $1.amount }
        
        var categorySummaries: [CategorySummary] = []
        let expensesByCategory = Dictionary(grouping: expenses, by: { $0.category })
        
        for budget in budgets {
            let categoryExpenses = expensesByCategory[budget.category]?.reduce(0) { $0 + $1.amount } ?? 0
            let remainingAmount = budget.amount - categoryExpenses
            
            categorySummaries.append(
                CategorySummary(
                    category: budget.category,
                    budgetAmount: budget.amount,
                    spentAmount: categoryExpenses,
                    remainingAmount: remainingAmount
                )
            )
        }
        
        return MonthlySummary(
            totalBudget: totalBudget,
            totalExpense: totalExpense,
            categorySummaries: categorySummaries
        )
    }
}

public struct MonthlySummary: Equatable {
    public let totalBudget: Int
    public let totalExpense: Int
    public let categorySummaries: [CategorySummary]
    
    public init(totalBudget: Int, totalExpense: Int, categorySummaries: [CategorySummary]) {
        self.totalBudget = totalBudget
        self.totalExpense = totalExpense
        self.categorySummaries = categorySummaries
    }
}

public struct CategorySummary: Equatable {
    public let category: Category
    public let budgetAmount: Int
    public let spentAmount: Int
    public let remainingAmount: Int
    
    public init(category: Category, budgetAmount: Int, spentAmount: Int, remainingAmount: Int) {
        self.category = category
        self.budgetAmount = budgetAmount
        self.spentAmount = spentAmount
        self.remainingAmount = remainingAmount
    }
}

enum SummaryError: Error {
    case invalidDate
}
