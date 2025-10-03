
//
//  DefaultExpenseRepository.swift
//  Data
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation
import Domain
import SwiftData

public final class DefaultExpenseRepository: ExpenseRepository {
    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func addExpense(_ expense: Domain.Expense) async throws {
        let expenseEntity = expense.toEntity()
        modelContext.insert(expenseEntity)
    }
    
    public func getMonthlyExpenses(for date: Date) async throws -> [Domain.Expense] {
        let calendar = Calendar.current
        let monthKey = DateKeys.monthKey(from: date, calendar: calendar)
        
        let predicate = #Predicate<ExpenseEntity> { $0.monthKey == monthKey }
        let descriptor = FetchDescriptor<ExpenseEntity>(predicate: predicate)
        
        let entities = try modelContext.fetch(descriptor)
        return entities.map { $0.toDomain() }
    }
    
    public func getBudget(for date: Date) async throws -> Domain.Budget? {
        let calendar = Calendar.current
        let monthKey = DateKeys.monthKey(from: date, calendar: calendar)
        
        let predicate = #Predicate<BudgetEntity> { $0.monthKey == monthKey }
        let descriptor = FetchDescriptor<BudgetEntity>(predicate: predicate)
        
        let entity = try modelContext.fetch(descriptor).first
        return entity?.toDomain()
    }
    
    public func getDailyExpenses(for date: Date, in interval: DateInterval) async throws -> [Domain.Expense] {
        let calendar = Calendar.current
        
        let startOfDay = calendar.startOfDay(for: interval.start)
        let endOfDay = calendar.startOfDay(for: interval.end)
        
        let predicate = #Predicate<ExpenseEntity> { entity in
            entity.date >= startOfDay && entity.date < endOfDay
        }
        let descriptor = FetchDescriptor<ExpenseEntity>(predicate: predicate)
        
        let entities = try modelContext.fetch(descriptor)
        return entities.map { $0.toDomain() }
    }
}
