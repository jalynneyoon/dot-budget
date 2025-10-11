
//
//  BudgetRepository.swift
//  Domain
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation

public protocol BudgetRepository {
    func setBudget(_ budget: Budget) throws
    func getBudgets(for monthKey: Int) throws -> [Budget]
}
