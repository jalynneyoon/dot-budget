
//
//  AddExpenseUseCase+Dependency.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import ComposableArchitecture
import Domain

public struct AddExpenseUseCaseDependency {
    
    public init(execute: @Sendable @escaping (Expense) async throws -> Void) {
        self.execute = execute
    }
    
    public var execute: @Sendable (Expense) async throws -> Void
}
  
extension AddExpenseUseCaseDependency: DependencyKey {
    public static var liveValue: AddExpenseUseCaseDependency {
        return AddExpenseUseCaseDependency(execute: {
            expense in
            print("AddExpenseUseCase.liveValue.execute called but not implemented")
        })
    }
    
    public static let testValue = Self(
        execute: { _ in
            print("AddExpenseUseCase.testValue.execute called")
        }
    )

    public static let previewValue = Self(
        execute: { expense in
            print("AddExpenseUseCase.previewValue.execute called with expense: \(expense.amount)")
        }
    )
}

public extension DependencyValues {
    var addExpenseUseCase: AddExpenseUseCaseDependency {
        get { self[AddExpenseUseCaseDependency.self] }
        set { self[AddExpenseUseCaseDependency.self] = newValue }
    }
}
