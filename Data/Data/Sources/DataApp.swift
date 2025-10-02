import SwiftData
import SwiftUI


@main
struct DataApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [CategoryEntity.self])
    }
}

struct RootView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        ContentView()
            .task {
                await bootstrapCategories(context: context)
            }
    }
}

@MainActor
func bootstrapCategories(context: ModelContext) async {
    let defaultCategories: [(String, String)] = [
        ("식비", "🍚"),
        ("교통", "🚗"),
        ("여가", "🎮")
    ]
    for (name, symbol) in defaultCategories {
        let fetchDescriptor = FetchDescriptor<CategoryEntity>(predicate: #Predicate { $0.name == name })
        let exists = (try? !context.fetch(fetchDescriptor).isEmpty) ?? false
        if !exists {
            let category = CategoryEntity(name: name, symbol: symbol, isDefault: true)
            context.insert(category)
        }
    }
    try? context.save()
}
