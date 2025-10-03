import SwiftUI
import SwiftData
import Data
import DI
import Home

@main
struct DotBudgetApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: ExpenseEntity.self, CategoryEntity.self, BudgetEntity.self, BadgeUnlockEntity.self)
            
            DI.bootstrap(container: container)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
