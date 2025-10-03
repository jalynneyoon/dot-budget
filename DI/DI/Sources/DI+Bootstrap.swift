//
//  DI+Bootstrap.swift
//  DI
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation
import Domain
import Dependencies
import Data
import SwiftData

public enum DI {
    public static func bootstrap(container: ModelContainer) {
        
        let modelContext = ModelContext(container)
        
        let repo = DefaultExpenseRepository(modelContext: modelContext)
        let addExpense = AddExpenseUseCase(expenseRepository: repo)
        withDependencies {
            $0.addExpenseUseCase = .init(execute: addExpense.execute)
        } operation: {}
    }
}
