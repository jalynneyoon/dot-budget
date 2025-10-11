import SwiftUI
import CoreTCA

@main
struct HomeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(
                store: Store(initialState: HomeReducer.State()) {
                    HomeReducer()
                }
            )
        }
    }
}
