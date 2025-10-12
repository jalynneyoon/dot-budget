import SwiftUI
import Domain
import Data
import CoreTCA
import SwiftData

public struct RootView<Content: View>: View {
    let container: ModelContainer
    let content: () -> Content

    public init(container: ModelContainer, @ViewBuilder content: @escaping () -> Content) {
        self.container = container
        self.content = content
    }

    public var body: some View {
        // Create repositories
        let expenseRepo = DefaultExpenseRepository(modelContext: ModelContext(container))
        let categoryRepo = DefaultCategoryRepository(modelContext: ModelContext(container))
        let budgetRepo = DefaultBudgetRepository(modelContext: ModelContext(container))
        
        // Create use cases
        let addExpense = AddExpenseUseCase(expenseRepository: expenseRepo)
        let getMonthlySummary = GetMonthlySummaryUseCase(expenseRepository: expenseRepo, budgetRepository: budgetRepo)
        let getHeatmapData = GetHeatmapDataUseCase(expenseRepository: expenseRepo)
        let getCategories = GetCategoriesUseCase(categoryRepository: categoryRepo)
        let addCategory = AddCategoryUseCase(categoryRepository: categoryRepo)
        let deleteCategory = DeleteCategoryUseCase(categoryRepository: categoryRepo)
        let setBudget = SetBudgetUseCase(budgetRepository: budgetRepo)
        let getBudgets = GetBudgetsUseCase(budgetRepository: budgetRepo)

        return withDependencies {
            // Override dependencies
            $0.addExpenseUseCase = .init(execute: addExpense.execute)
            $0.getMonthlySummaryUseCase = .init(execute: getMonthlySummary.execute)
            $0.getHeatmapDataUseCase = .init(execute: getHeatmapData.execute)
            $0.getCategoriesUseCase = .init(execute: getCategories.execute)
            $0.addCategoryUseCase = .init(execute: addCategory.execute)
            $0.deleteCategoryUseCase = .init(execute: deleteCategory.execute)
            $0.setBudgetUseCase = .init(execute: setBudget.execute)
            $0.getBudgetsUseCase = .init(execute: getBudgets.execute)
        } operation: {
            content()
        }
    }
}
