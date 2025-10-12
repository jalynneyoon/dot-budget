
import SwiftUI
import Domain
import Shared
import CoreTCA

public struct BudgetView: View {
    public init(store: StoreOf<BudgetReducer>) {
        self.store = store
    }
    
    let store: StoreOf<BudgetReducer>

    public var body: some View {
        NavigationStack {
            Form {
                ForEach(store.state.categories) { category in
                    HStack {
                        Text(category.name)
                        Spacer()
                        TextField("예산을 입력해 주세요", text: .init(get: {
                            store.state.budgets.first(where: { $0.category == category })?.amount.description ?? ""
                        }, set: { amount in
                            store.send(.setBudget(category: category, amount: amount))
                        }))
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                    }
                }
            }
            .navigationTitle("월별 예산 설정")
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

#Preview {
    BudgetView(
        store: Store(
            initialState: BudgetReducer.State(
                monthKey: DateKeys.monthKey(from: Date(), calendar: Calendar.current)
            )
        ) {
            BudgetReducer()
        }
    )
}
