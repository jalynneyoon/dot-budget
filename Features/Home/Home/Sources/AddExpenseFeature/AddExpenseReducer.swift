import ComposableArchitecture
import Foundation
import Domain
import Shared

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
            case cancelTapped
        }
    }

    @Dependency(\.addExpenseUseCase) var addExpenseUseCase

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .saveButtonTapped:
                guard let amount = Int(state.amount) else {
                    // TODO: Show validation error to user
                    return .none
                }
                
                let newExpense = Expense(
                    id: UUID(),
                    date: state.expenseDate,
                    amount: amount,
                    category: Category(id: UUID(), name: "food", symbol: "dd", isDefault: false),
                    memo: state.memo,
                    dayKey: DateKeys.dayKey(from: Date()),
                    monthKey: DateKeys.monthKey(from: Date()),
                    createdAt: .now,
                    updatedAt: .now
                )
                
                return .run { send in
                    try await self.addExpenseUseCase.execute(newExpense)
                    await send(.delegate(.expenseSaved))
                }

            case .cancelButtonTapped:
                return .send(.delegate(.cancelTapped))

            case .binding, .delegate:
                return .none
            }
        }
    }
}
