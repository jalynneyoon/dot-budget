import SwiftUI
import SwiftData
import ComposableArchitecture

import Domain
import Data
import DI

@main
struct DotBudgetApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: ExpenseEntity.self, CategoryEntity.self, BudgetEntity.self, BadgeUnlockEntity.self)
            
            // Bootstrap all live dependencies via DI module
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