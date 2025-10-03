
//
//  ExpenseRepository.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public protocol ExpenseRepository {
    func addExpense(_ expense: Expense) async throws
    func getMonthlyExpenses(for date: Date) async throws -> [Expense]
    func getBudget(for date: Date) async throws -> Budget?
    func getDailyExpenses(for date: Date, in interval: DateInterval) async throws -> [Expense]
}
