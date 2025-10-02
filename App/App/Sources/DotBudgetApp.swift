import SwiftUI
import SwiftData
import ComposableArchitecture
import Domain
import Data
import Dependencies
import Home

@main
struct DotBudgetApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: ExpenseEntity.self, CategoryEntity.self, BudgetEntity.self, BadgeUnlockEntity.self)
            
            let modelContext = ModelContext(container)
            let expenseRepository = DefaultExpenseRepository(modelContext: modelContext)
            let useCase = AddExpenseUseCase(expenseRepository: expenseRepository)
            
            withDependencies {
                $0.addExpenseUseCase = AddExpenseUseCaseDependency(
                    execute: useCase.execute
                )
            } operation: {}
            
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            withDependencies { _ in
                
            } operation: {
                ContentView()
            }
        }
        .modelContainer(container)
    }
}
