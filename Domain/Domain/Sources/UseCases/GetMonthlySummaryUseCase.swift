
//
//  GetMonthlySummaryUseCase.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public final class GetMonthlySummaryUseCase {
    private let expenseRepository: ExpenseRepository

    public init(expenseRepository: ExpenseRepository) {
        self.expenseRepository = expenseRepository
    }

    public func execute(for date: Date) async throws -> MonthlySummary {
        let calendar = Calendar.current
        
        // Current Month Data
        let currentMonthExpenses = try await expenseRepository.getMonthlyExpenses(for: date)
        let currentMonthTotal = currentMonthExpenses.reduce(0) { $0 + $1.amount }
        let currentMonthBudget = try await expenseRepository.getBudget(for: date)
        
        // Previous Month Data
        guard let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: date) else { throw SummaryError.invalidDate }
        let previousMonthExpenses = try await expenseRepository.getMonthlyExpenses(for: previousMonthDate)
        let previousMonthTotal = previousMonthExpenses.reduce(0) { $0 + $1.amount }
        
        // Calculate percentage against budget
        var budgetPercentage: Double = 0
        if let budgetAmount = currentMonthBudget?.amount, budgetAmount > 0 {
            budgetPercentage = Double(currentMonthTotal) / Double(budgetAmount) * 100
        }
        
        // Calculate feedback message
        var feedbackMessage: String = ""
        if previousMonthTotal > 0 {
            let percentageChange = (Double(previousMonthTotal) - Double(currentMonthTotal)) / Double(previousMonthTotal) * 100
            if percentageChange > 0 {
                feedbackMessage = "저번 달보다 \(Int(percentageChange))% 절약했어요!"
            } else if percentageChange < 0 {
                feedbackMessage = "저번 달보다 \(Int(-percentageChange))% 더 지출했어요."
            } else {
                feedbackMessage = "저번 달과 비슷한 수준으로 지출했어요."
            }
        } else {
            feedbackMessage = "이번 달 지출을 시작했어요!"
        }
        
        return MonthlySummary(
            totalExpense: currentMonthTotal,
            budgetPercentage: budgetPercentage,
            feedbackMessage: feedbackMessage
        )
    }
}

public struct MonthlySummary: Equatable {
    public let totalExpense: Int
    public let budgetPercentage: Double
    public let feedbackMessage: String
    
    public init(totalExpense: Int, budgetPercentage: Double, feedbackMessage: String) {
        self.totalExpense = totalExpense
        self.budgetPercentage = budgetPercentage
        self.feedbackMessage = feedbackMessage
    }
}

enum SummaryError: Error {
    case invalidDate
}
