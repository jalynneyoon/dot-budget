import SwiftUI
import ComposableArchitecture

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
