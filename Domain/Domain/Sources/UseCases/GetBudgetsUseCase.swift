
//
//  GetBudgetsUseCase.swift
//  Domain
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation


public final class GetBudgetsUseCase {
    private let budgetRepository: BudgetRepository

    public init(budgetRepository: BudgetRepository) {
        self.budgetRepository = budgetRepository
    }

    public func execute(for monthKey: Int) throws -> [Budget] {
        try budgetRepository.getBudgets(for: monthKey)
    }
}
