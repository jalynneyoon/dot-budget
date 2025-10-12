import SwiftUI
import SwiftData
import Data
import DI

@main
struct DotBudgetApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: ExpenseEntity.self, CategoryEntity.self, BudgetEntity.self, BadgeUnlockEntity.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(container: self.container) {
                ContentView()
            }
        }
        .modelContainer(container)
    }
}
