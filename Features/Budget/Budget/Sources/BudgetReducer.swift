
import Foundation
import Domain
import CoreTCA

@Reducer
public struct BudgetReducer {
    @ObservableState
    public struct State: Equatable {
        var budgets: [Domain.Budget] = []
        var categories: [Domain.Category] = []
        var monthKey: Int
        
        public init(budgets: [Domain.Budget] = [], categories: [Domain.Category] = [], monthKey: Int) {
            self.budgets = budgets
            self.categories = categories
            self.monthKey = monthKey
        }
    }

    public enum Action: Equatable {
        case onAppear
        case budgetsLoaded([Domain.Budget])
        case categoriesLoaded([Domain.Category])
        case setBudget(category: Domain.Category, amount: String)
    }

    @Dependency(\.getBudgetsUseCase) var getBudgetsUseCase
    @Dependency(\.getCategoriesUseCase) var getCategoriesUseCase
    @Dependency(\.setBudgetUseCase) var setBudgetUseCase
    
    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { [monthKey = state.monthKey] send in
                    let budgets = try getBudgetsUseCase.execute(monthKey)
                    await send(.budgetsLoaded(budgets))
                    let categories = getCategoriesUseCase.execute()
                    await send(.categoriesLoaded(categories))
                }

            case .budgetsLoaded(let budgets):
                state.budgets = budgets
                return .none

            case .categoriesLoaded(let categories):
                state.categories = categories
                return .none

            case .setBudget(let category, let amount):
                guard let amountValue = Int(amount) else { return .none }
                let budget = Budget(id: UUID(), monthKey: state.monthKey, category: category, amount: amountValue)
                return .run { [budget] send in
                    try setBudgetUseCase.execute(budget)
                    // Refresh budgets
                    let budgets = try getBudgetsUseCase.execute(budget.monthKey)
                    await send(.budgetsLoaded(budgets))
                }
            }
        }
    }
}
