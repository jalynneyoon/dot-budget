//
//  UseCase+Dependency.swift
//  Domain
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation
import CoreTCA
import Domain

// MARK: - AddExpenseUseCase Dependency
public struct AddExpenseUseCaseDependency {
    public init(execute: @escaping (Expense) async throws -> Void) {
        self.execute = execute
    }
    
    public var execute: (Expense) async throws -> Void
}

extension AddExpenseUseCaseDependency: DependencyKey {
    public static let liveValue = Self(
        execute: { _ in
            fatalError("AddExpenseUseCase not implemented in live environment")
        }
    )
    public static let testValue = Self(
        execute: { _ in
            print("AddExpenseUseCase.testValue.execute called")
        }
    )
    public static let previewValue = Self(
        execute: { _ in
            print("AddExpenseUseCase.previewValue.execute called")
        }
    )
}

public extension DependencyValues {
    var addExpenseUseCase: AddExpenseUseCaseDependency {
        get { self[AddExpenseUseCaseDependency.self] }
        set { self[AddExpenseUseCaseDependency.self] = newValue }
    }
}

// MARK: - GetMonthlySummaryUseCase Dependency
public struct GetMonthlySummaryUseCaseDependency {
    public init(execute: @escaping (Date) async throws -> MonthlySummary) {
        self.execute = execute
    }
    
    public var execute: (Date) async throws -> MonthlySummary
}

extension GetMonthlySummaryUseCaseDependency: DependencyKey {
    public static let liveValue = Self(
        execute: { _ in
            fatalError("GetMonthlySummaryUseCase not implemented in live environment")
        }
    )
    public static let testValue = Self(
        execute: { _ in
            MonthlySummary(
                totalBudget: 2000,
                totalExpense: 0,
                categorySummaries: [
                    CategorySummary(
                        category: .init(id: UUID(), name: "식비", symbol: "🍚", isDefault: true),
                        budgetAmount: 5000,
                        spentAmount: 0,
                        remainingAmount: 5000
                    )
                ]
            )
        }
    )
    public static let previewValue = Self(
        execute: { _ in
            MonthlySummary(
                totalBudget: 10000,
                totalExpense: 7500,
                categorySummaries: [
                    CategorySummary(
                        category: .init(id: UUID(), name: "식비", symbol: "🍚", isDefault: true),
                        budgetAmount: 5000,
                        spentAmount: 3000,
                        remainingAmount: 2000
                    ),
                    CategorySummary(
                        category: .init(id: UUID(), name: "교통", symbol: "🚗", isDefault: true),
                        budgetAmount: 3000,
                        spentAmount: 2000,
                        remainingAmount: 1000
                    ),
                    CategorySummary(
                        category: .init(id: UUID(), name: "쇼핑", symbol: "🛍️", isDefault: true),
                        budgetAmount: 2000,
                        spentAmount: 2500,
                        remainingAmount: -500
                    )
                ]
            )
        }
    )
}

public extension DependencyValues {
    var getMonthlySummaryUseCase: GetMonthlySummaryUseCaseDependency {
        get { self[GetMonthlySummaryUseCaseDependency.self] }
        set { self[GetMonthlySummaryUseCaseDependency.self] = newValue }
    }
}

// MARK: - GetHeatmapDataUseCase Dependency
public struct GetHeatmapDataUseCaseDependency {
    public init(execute: @escaping (Date) async throws -> [Date: Int]) {
        self.execute = execute
    }
    
    public var execute: (Date) async throws -> [Date: Int]
}

extension GetHeatmapDataUseCaseDependency: DependencyKey {
    public static let liveValue = Self(
        execute: { _ in
            // Not implemented in live environment yet. Return an empty dataset to satisfy the type.
            // You can switch this to `fatalError` if you prefer a hard failure:
            // fatalError("GetHeatmapDataUseCase not implemented in live environment")
            return [:]
        }
    )
    public static let testValue = Self(
        execute: { _ in
            [:] // Return empty dictionary for tests
        }
    )
    public static let previewValue = Self(
        execute: { _ in
            let calendar = Calendar.current
            let today = Date()
            var previewData: [Date: Int] = [:]
            for i in 0..<30 {
                if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                    previewData[calendar.startOfDay(for: date)] = Int.random(in: 0...50000)
                }
            }
            return previewData
        }
    )
}

public extension DependencyValues {
    var getHeatmapDataUseCase: GetHeatmapDataUseCaseDependency {
        get { self[GetHeatmapDataUseCaseDependency.self] }
        set { self[GetHeatmapDataUseCaseDependency.self] = newValue }
    }
}

// MARK: - GetCategoriesUseCase Dependency
public struct GetCategoriesUseCaseDependency {
    public init(execute: @escaping () -> [Domain.Category]) {
        self.execute = execute
    }
    
    public var execute: () -> [Domain.Category]
}

extension GetCategoriesUseCaseDependency: DependencyKey {
    public static let liveValue = Self(
        execute: { 
            fatalError("GetCategoriesUseCase not implemented in live environment")
        }
    )
    public static let testValue = Self(
        execute: { [] }
    )
    public static let previewValue = Self(
        execute: {
            [
                Domain.Category(id: UUID(), name: "식비", symbol: "🍚", isDefault: true),
                Domain.Category(id: UUID(), name: "교통", symbol: "🚗", isDefault: true),
                Domain.Category(id: UUID(), name: "쇼핑", symbol: "🛍️", isDefault: true),
            ]
        }
    )
}

public extension DependencyValues {
    var getCategoriesUseCase: GetCategoriesUseCaseDependency {
        get { self[GetCategoriesUseCaseDependency.self] }
        set { self[GetCategoriesUseCaseDependency.self] = newValue }
    }
}

// MARK: - AddCategoryUseCase Dependency
public struct AddCategoryUseCaseDependency {
    public init(execute: @escaping (Domain.Category) throws -> Void) {
        self.execute = execute
    }
    
    public var execute: (Domain.Category) throws -> Void
}

extension AddCategoryUseCaseDependency: DependencyKey {
    public static let liveValue = Self(
        execute: { _ in
            fatalError("AddCategoryUseCase not implemented in live environment")
        }
    )
    public static let testValue = Self(
        execute: { _ in
            print("AddCategoryUseCase.testValue.execute called")
        }
    )
    public static let previewValue = Self(
        execute: { _ in
            print("AddCategoryUseCase.previewValue.execute called")
        }
    )
}

public extension DependencyValues {
    var addCategoryUseCase: AddCategoryUseCaseDependency {
        get { self[AddCategoryUseCaseDependency.self] }
        set { self[AddCategoryUseCaseDependency.self] = newValue }
    }
}

// MARK: - DeleteCategoryUseCase Dependency
public struct DeleteCategoryUseCaseDependency {
    public init(execute: @escaping (Domain.Category) throws -> Void) {
        self.execute = execute
    }
    
    public var execute: (Domain.Category) throws -> Void
}

extension DeleteCategoryUseCaseDependency: DependencyKey {
    public static let liveValue = Self(
        execute: { _ in
            fatalError("DeleteCategoryUseCase not implemented in live environment")
        }
    )
    public static let testValue = Self(
        execute: { _ in
            print("DeleteCategoryUseCase.testValue.execute called")
        }
    )
    public static let previewValue = Self(
        execute: { _ in
            print("DeleteCategoryUseCase.previewValue.execute called")
        }
    )
}

public extension DependencyValues {
    var deleteCategoryUseCase: DeleteCategoryUseCaseDependency {
        get { self[DeleteCategoryUseCaseDependency.self] }
        set { self[DeleteCategoryUseCaseDependency.self] = newValue }
    }
}

// MARK: - SetBudgetUseCase Dependency
public struct SetBudgetUseCaseDependency {
    public init(execute: @escaping (Budget) throws -> Void) {
        self.execute = execute
    }
    
    public var execute: (Budget) throws -> Void
}

extension SetBudgetUseCaseDependency: DependencyKey {
    public static let liveValue = Self(
        execute: { _ in
            fatalError("SetBudgetUseCase not implemented in live environment")
        }
    )
    public static let testValue = Self(
        execute: { _ in
            print("SetBudgetUseCase.testValue.execute called")
        }
    )
    public static let previewValue = Self(
        execute: { _ in
            print("SetBudgetUseCase.previewValue.execute called")
        }
    )
}

public extension DependencyValues {
    var setBudgetUseCase: SetBudgetUseCaseDependency {
        get { self[SetBudgetUseCaseDependency.self] }
        set { self[SetBudgetUseCaseDependency.self] = newValue }
    }
}

// MARK: - GetBudgetsUseCase Dependency
public struct GetBudgetsUseCaseDependency {
    public init(execute: @escaping (Int) throws -> [Budget]) {
        self.execute = execute
    }
    
    public var execute: (Int) throws -> [Budget]
}

extension GetBudgetsUseCaseDependency: DependencyKey {
    public static let liveValue = Self(
        execute: { _ in
            fatalError("GetBudgetsUseCase not implemented in live environment")
        }
    )
    public static let testValue = Self(
        execute: { _ in [] }
    )
    public static let previewValue = Self(
        execute: { _ in [] }
    )
}

public extension DependencyValues {
    var getBudgetsUseCase: GetBudgetsUseCaseDependency {
        get { self[GetBudgetsUseCaseDependency.self] }
        set { self[GetBudgetsUseCaseDependency.self] = newValue }
    }
}
