//
//  AddExpenseUseCase.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public final class AddExpenseUseCase {
    private let expenseRepository: ExpenseRepository

    public init(expenseRepository: ExpenseRepository) {
        self.expenseRepository = expenseRepository
    }

    public func execute(_ expense: Expense) async throws {
        try await expenseRepository.addExpense(expense)
    }
}
