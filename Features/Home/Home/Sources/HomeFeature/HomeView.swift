import SwiftUI
import ComposableArchitecture
import Domain
import Shared

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
    // MockExpenseRepository를 사용하여 UseCase들을 생성하고 주입
    let mockRepo = MockExpenseRepository(
        initialExpenses: [
            Expense(id: UUID(), date: Date().addingTimeInterval(-86400*20), amount: 25000, category: nil, memo: "Mock Expense 1", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now),
            Expense(id: UUID(), date: Date().addingTimeInterval(-86400*60), amount: 10000, category: nil, memo: "Mock Expense 2", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now),
            Expense(id: UUID(), date: Date().addingTimeInterval(-86400*1), amount: 3200, category: nil, memo: "Mock Expense 3", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now),
            Expense(id: UUID(), date: Date(), amount: 300000, category: nil, memo: "Mock Expense 4", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now)

        ],
        initialBudgets: [
            Budget(id: UUID(), monthKey: DateKeys.monthKey(from: .now), category: Category(id: UUID(), name: "식비", symbol: "fork.knife", isDefault: true), amount: 500000)
        ]
    )
    let addExpenseUseCase = AddExpenseUseCase(expenseRepository: mockRepo)
    let getMonthlySummaryUseCase = GetMonthlySummaryUseCase(expenseRepository: mockRepo)
    let getHeatmapDataUseCase = GetHeatmapDataUseCase(expenseRepository: mockRepo)

    withDependencies {
        $0.addExpenseUseCase = .init(execute: addExpenseUseCase.execute)
        $0.getMonthlySummaryUseCase = .init(execute: getMonthlySummaryUseCase.execute)
        $0.getHeatmapDataUseCase = .init(execute: getHeatmapDataUseCase.execute)
    } operation: {
        HomeView(
            store: Store(initialState: HomeReducer.State()) {
                HomeReducer()
            }
        )
    }
}
