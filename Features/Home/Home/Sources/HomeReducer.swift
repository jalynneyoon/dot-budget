
import ComposableArchitecture

@Reducer
struct HomeReducer {
    @ObservableState
    public struct State: Equatable {
        @Presents var addExpense: AddExpenseReducer.State?
    }

    enum Action {
        case fabButtonTapped
        case addExpense(PresentationAction<AddExpenseReducer.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fabButtonTapped:
                state.addExpense = .init()
                return .none

            case .addExpense(.presented(.cancelButtonTapped)):
                state.addExpense = nil
                return .none

            case .addExpense(.presented(.delegate(.expenseSaved))):
                state.addExpense = nil
                return .none

            case .addExpense:
                return .none
            }
        }
        .ifLet(\.$addExpense, action: \.addExpense) {
            AddExpenseReducer()
        }
    }
}
