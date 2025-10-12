import SwiftUI
import Home
import Statistics
import CoreTCA

struct ContentView: View {
    let homeStore: StoreOf<HomeReducer>

    init() {
        self.homeStore = Store(initialState: HomeReducer.State()) {
            HomeReducer()
        }
    }

    var body: some View {
        TabView {
            HomeView(store: self.homeStore)
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
    ContentView()
}
