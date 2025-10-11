import SwiftUI
import Home
import Statistics
import ComposableArchitecture

struct ContentView: View {

    var body: some View {
        TabView {
            HomeView(
                store: Store(
                    initialState: HomeReducer.State(),
                    reducer: {
                        Reduce<HomeReducer.State, HomeReducer.Action> { _, _ in .none }
                    }
                )
            )
            .tabItem {
                Label("홈", systemImage: "house.fill")
            }
            
            StatisticsView()
                .tabItem {
                    Label("통계", systemImage: "chart.bar.xaxis")
                }
        }
    }
}

#Preview {
    ContentView(
    )
}
