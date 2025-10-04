
import ComposableArchitecture

@Reducer
struct HomeReducer {
    @ObservableState
    public struct State: Equatable {
        @Presents var addExpense: AddExpenseReducer.State?
        var summaryCard: SummaryCardReducer.State = SummaryCardReducer.State()
        var heatmap: HeatmapReducer.State = HeatmapReducer.State()
    }

    enum Action {
        case fabButtonTapped
        case addExpense(PresentationAction<AddExpenseReducer.Action>)
        case summaryCard(SummaryCardReducer.Action)
        case heatmap(HeatmapReducer.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fabButtonTapped:
                state.addExpense = .init()
                return .none

            case .addExpense(.presented(.delegate(.expenseSaved))):
                state.addExpense = nil
                return .merge(
                    .send(.summaryCard(.onAppear)),
                    .send(.heatmap(.onAppear))
                )

            case .addExpense(.presented(.delegate(.cancelTapped))):
                state.addExpense = nil
                return .none

            case .addExpense:
                return .none
                
            case .summaryCard:
                return .none
                
            case .heatmap:
                return .none
            }
        }
        .ifLet(\.$addExpense, action: \.addExpense) {
            AddExpenseReducer()
        }
        Scope(state: \.summaryCard, action: \.summaryCard) {
            SummaryCardReducer()
        }
        Scope(state: \.heatmap, action: \.heatmap) {
            HeatmapReducer()
        }
    }
}
