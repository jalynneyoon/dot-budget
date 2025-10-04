//
//  DI+Bootstrap.swift
//  DI
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation
import Domain
import ComposableArchitecture
import Data
import SwiftData

public enum DI {
    public static func bootstrap(container: ModelContainer) {
        
        let modelContext = ModelContext(container)
        
        let expenseRepo = DefaultExpenseRepository(modelContext: modelContext)
        let categoryRepo = DefaultCategoryRepository(modelContext: modelContext)
        
        let addExpense = AddExpenseUseCase(expenseRepository: expenseRepo)
        let getMonthlySummary = GetMonthlySummaryUseCase(expenseRepository: expenseRepo)
        let getHeatmapData = GetHeatmapDataUseCase(expenseRepository: expenseRepo)
        let getCategories = GetCategoriesUseCase(categoryRepository: categoryRepo)
        let addCategory = AddCategoryUseCase(categoryRepository: categoryRepo)
        let deleteCategory = DeleteCategoryUseCase(categoryRepository: categoryRepo)
        
        withDependencies {
            $0.addExpenseUseCase = .init(execute: addExpense.execute)
            $0.getMonthlySummaryUseCase = .init(execute: getMonthlySummary.execute)
            $0.getHeatmapDataUseCase = .init(execute: getHeatmapData.execute)
            $0.getCategoriesUseCase = .init(execute: getCategories.execute)
            $0.addCategoryUseCase = .init(execute: addCategory.execute)
            $0.deleteCategoryUseCase = .init(execute: deleteCategory.execute)
        } operation: {}
    }
}
