import SwiftUI
import Home
import Statistics

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
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
