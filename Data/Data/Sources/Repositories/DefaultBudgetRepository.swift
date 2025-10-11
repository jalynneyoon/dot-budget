
//
//  DefaultBudgetRepository.swift
//  Data
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation
import Domain
import SwiftData

public final class DefaultBudgetRepository: BudgetRepository {
    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func setBudget(_ budget: Budget) throws {
        // Capture primitive values to use inside #Predicate
        let monthKey = budget.monthKey
        let categoryID = budget.category.id

        let predicate = #Predicate<BudgetEntity> { entity in
            entity.monthKey == monthKey && entity.category.id == categoryID
        }
        let descriptor = FetchDescriptor<BudgetEntity>(predicate: predicate)
        
        if let entity = try modelContext.fetch(descriptor).first {
            entity.amount = budget.amount
        } else {
            let newBudgetEntity = BudgetEntity(
                monthKey: budget.monthKey,
                category: budget.category.toEntity(),
                amount: budget.amount
            )
            modelContext.insert(newBudgetEntity)
        }
    }

    public func getBudgets(for monthKey: Int) throws -> [Budget] {
        let monthKey = monthKey
        let predicate = #Predicate<BudgetEntity> { $0.monthKey == monthKey }
        let descriptor = FetchDescriptor<BudgetEntity>(predicate: predicate)
        
        let entities = try modelContext.fetch(descriptor)
        return entities.map { $0.toDomain() }
    }
}

