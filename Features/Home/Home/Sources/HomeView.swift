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
        ZStack(alignment: .bottomTrailing) {
            // Main content of the home screen
            VStack {
                Text("내역이 없습니다.") // Placeholder
            }

            // Floating Action Button
            Button(action: { 
                store.send(.fabButtonTapped)
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


#Preview {
    HomeView(
        store: Store(initialState: HomeReducer.State()) {
            HomeReducer()
        }
    )
}
