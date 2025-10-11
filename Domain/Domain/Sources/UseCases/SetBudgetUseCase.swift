
//
//  SetBudgetUseCase.swift
//  Domain
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation

public final class SetBudgetUseCase {
    private let budgetRepository: BudgetRepository

    public init(budgetRepository: BudgetRepository) {
        self.budgetRepository = budgetRepository
    }

    public func execute(_ budget: Budget) throws {
        try budgetRepository.setBudget(budget)
    }
}
