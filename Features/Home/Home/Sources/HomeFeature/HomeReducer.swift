import Foundation
import Domain
import Budget
import Shared
import CoreTCA

@Reducer
public struct HomeReducer {
    @ObservableState
    public struct State: Equatable {
        @Presents var addExpense: AddExpenseReducer.State?
        @Presents var budget: BudgetReducer.State?
        var summaryCard: SummaryCardReducer.State = SummaryCardReducer.State()
        var heatmap: HeatmapReducer.State = HeatmapReducer.State()
        
        public init() {}
    }

    public enum Action: Equatable {
        case fabButtonTapped
        case budgetButtonTapped
        case addExpense(PresentationAction<AddExpenseReducer.Action>)
        case budget(PresentationAction<BudgetReducer.Action>)
        case summaryCard(SummaryCardReducer.Action)
        case heatmap(HeatmapReducer.Action)
    }

    public var body: some ReducerOf<Self> {
        Reduce<HomeReducer.State, HomeReducer.Action> { state, action in
            switch action {
            case .fabButtonTapped:
                state.addExpense = AddExpenseReducer.State()
                return .none

            case .budgetButtonTapped:
                state.budget = BudgetReducer.State(monthKey: DateKeys.monthKey(from: .now))
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

//            case .budget(.presented(.delegate(.cancelTapped))):
//                state.budget = nil
//                return .none

            case .addExpense, .budget, .summaryCard, .heatmap:
                return .none
            }
        }
        .ifLet(\.$addExpense, action: \.addExpense) {
            AddExpenseReducer()
        }
        .ifLet(\.$budget, action: \.budget) {
            BudgetReducer()
        }
        Scope(state: \.summaryCard, action: \.summaryCard) {
            SummaryCardReducer()
        }
        Scope(state: \.heatmap, action: \.heatmap) {
            HeatmapReducer()
        }
    }
}
