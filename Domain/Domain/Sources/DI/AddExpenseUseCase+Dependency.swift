//
////
////  AddExpenseUseCase+Dependency.swift
////  Domain
////
////  Created by JohyeonYoon on 10/2/25.
////
//
//import ComposableArchitecture
//
//public struct AddExpenseUseCaseDependency {
//    public var execute: @Sendable (Expense) async throws -> Void
//}
//
//extension AddExpenseUseCaseDependency: DependencyKey {
//    public static let liveValue = Self(
//        execute: { expense in
//            // This is where the real implementation will be injected
//            // For now, it does nothing.
//            // We will replace this at the app's entry point.
//            print("AddExpenseUseCase.liveValue.execute called but not implemented")
//        }
//    )
//
//    public static let testValue = Self(
//        execute: { _ in
//            print("AddExpenseUseCase.testValue.execute called")
//        }
//    )
//
//    public static let previewValue = Self(
//        execute: { expense in
//            print("AddExpenseUseCase.previewValue.execute called with expense: \(expense.amount)")
//        }
//    )
//}
//
//public extension DependencyValues {
//    var addExpenseUseCase: AddExpenseUseCaseDependency {
//        get { self[AddExpenseUseCaseDependency.self] }
//        set { self[AddExpenseUseCaseDependency.self] = newValue }
//    }
//}
