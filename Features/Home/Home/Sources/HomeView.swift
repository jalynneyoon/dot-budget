import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
    let store: StoreOf<HomeReducer>

    init(store: StoreOf<HomeReducer>) {
        self.store = store
    }

    public init() {
        self.store = Store(initialState: HomeReducer.State()) {
            HomeReducer()
        }
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        SummaryCardView(
                            store: self.store.scope(state: \.summaryCard, action: \.summaryCard)
                        )
                        .padding(.horizontal)
                        
                        HeatmapView(
                            store: self.store.scope(state: \.heatmap, action: \.heatmap)
                        )
                        .padding(.vertical)
                        
                        Text("내역이 없습니다.")
                            .padding()
                    }
                }

                Button(action: { 
                    viewStore.send(.fabButtonTapped)
                }) {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }
                .padding()
            }
            .sheet(store: self.store.scope(state: \.$addExpense, action: \.addExpense)) { store in
                AddExpenseView(store: store)
            }
        }
    }
}

#Preview {
    HomeView(
        store: Store(initialState: HomeReducer.State()) {
            HomeReducer()
        }
    )
}
