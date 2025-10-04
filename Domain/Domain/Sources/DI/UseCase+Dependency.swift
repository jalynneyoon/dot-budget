//
//  UseCase+Dependency.swift
//  Domain
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation
import ComposableArchitecture

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
            .init(totalExpense: 0, budgetPercentage: 0, feedbackMessage: "Test feedback")
        }
    )
    public static let previewValue = Self(
        execute: { _ in
            .init(totalExpense: 12345, budgetPercentage: 75, feedbackMessage: "저번 달 보다 10% 절약하셨네요! 잘하고 있어요!")
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
            fatalError("GetHeatmapDataUseCase not implemented in live environment")
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
    public init(execute: @escaping () -> [Category]) {
        self.execute = execute
    }
    
    public var execute: () -> [Category]
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
                Category(id: UUID(), name: "식비", symbol: "🍚", isDefault: true),
                Category(id: UUID(), name: "교통", symbol: "🚗", isDefault: true),
                Category(id: UUID(), name: "쇼핑", symbol: "🛍️", isDefault: true),
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
    public init(execute: @escaping (Category) throws -> Void) {
        self.execute = execute
    }
    
    public var execute: (Category) throws -> Void
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
    public init(execute: @escaping (Category) throws -> Void) {
        self.execute = execute
    }
    
    public var execute: (Category) throws -> Void
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