
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
    public init(execute: @Sendable @escaping (Expense) async throws -> Void) {
        self.execute = execute
    }
    
    public var execute: @Sendable (Expense) async throws -> Void
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
    public init(execute: @Sendable @escaping (Date) async throws -> MonthlySummary) {
        self.execute = execute
    }
    
    public var execute: @Sendable (Date) async throws -> MonthlySummary
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
    public init(execute: @Sendable @escaping (Date) async throws -> [Date: Int]) {
        self.execute = execute
    }
    
    public var execute: @Sendable (Date) async throws -> [Date: Int]
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
