import ComposableArchitecture
import Foundation
import Domain

@Reducer
struct AddExpenseReducer {
    @ObservableState
    struct State: Equatable {
        var amount: String = ""
        var selectedCategory: Domain.Category? 
        var expenseDate: Date = .now
        var memo: String = ""
        var categories: [Domain.Category] = []
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case cancelButtonTapped
        case saveButtonTapped
        case delegate(Delegate)
        
        enum Delegate {
            case expenseSaved
        }
    }

    @Dependency(\.addExpenseUseCase) var addExpenseUseCase

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .saveButtonTapped:
                guard let amount = Int(state.amount), let category = state.selectedCategory else {
                    // TODO: Show validation error to user
                    return .none
                }
                
                let newExpense = Expense(
                    id: UUID(),
                    date: state.expenseDate,
                    amount: amount,
                    category: category,
                    memo: state.memo,
                    dayKey: 0, // TODO: Calculate keys
                    monthKey: 0, // TODO: Calculate keys
                    createdAt: .now,
                    updatedAt: .now
                )
                
                return .run { send in
                    try await self.addExpenseUseCase.execute(newExpense)
                    await send(.delegate(.expenseSaved))
                }

            case .binding, .cancelButtonTapped, .delegate:
                return .none
            }
        }
    }
}
