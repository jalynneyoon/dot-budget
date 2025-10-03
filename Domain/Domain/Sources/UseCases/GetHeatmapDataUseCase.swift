
//
//  GetHeatmapDataUseCase.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public final class GetHeatmapDataUseCase {
    private let expenseRepository: ExpenseRepository

    public init(expenseRepository: ExpenseRepository) {
        self.expenseRepository = expenseRepository
    }

    public func execute(for month: Date) async throws -> [Date: Int] {
        let calendar = Calendar.current
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else {
            throw HeatmapError.invalidDate
        }

        let expenses = try await expenseRepository.getDailyExpenses(for: month, in: monthInterval)

        var dailyTotals: [Date: Int] = [:]
        for expense in expenses {
            let day = calendar.startOfDay(for: expense.date)
            dailyTotals[day, default: 0] += expense.amount
        }
        return dailyTotals
    }
}

enum HeatmapError: Error {
    case invalidDate
}
