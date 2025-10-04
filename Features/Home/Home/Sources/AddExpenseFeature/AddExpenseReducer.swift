
import ComposableArchitecture
import Foundation
import Domain
import Shared

@Reducer
struct AddExpenseReducer {
    @Reducer(state: .equatable)
    enum Destination {
        case addCategory(AddCategoryReducer)
    }
    
    @ObservableState
    struct State: Equatable {
        var amount: String = ""
        var selectedCategory: Domain.Category? 
        var expenseDate: Date = .now
        var memo: String = ""
        var categories: [Domain.Category] = []
        @Presents var destination: Destination.State?
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case cancelButtonTapped
        case saveButtonTapped
        case onAppear
        case categoriesLoaded([Domain.Category])
        case addCategoryButtonTapped
        case deleteCategory(Domain.Category)
        case destination(PresentationAction<Destination.Action>)
        case delegate(Delegate)
        
        enum Delegate {
            case expenseSaved
            case cancelTapped
        }
    }

    @Dependency(\.addExpenseUseCase) var addExpenseUseCase
    @Dependency(\.getCategoriesUseCase) var getCategoriesUseCase
    @Dependency(\.addCategoryUseCase) var addCategoryUseCase
    @Dependency(\.deleteCategoryUseCase) var deleteCategoryUseCase

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    let categories = getCategoriesUseCase.execute()
                    await send(.categoriesLoaded(categories))
                }
            
            case .categoriesLoaded(let categories):
                state.categories = categories
                return .none

            case .addCategoryButtonTapped:
                state.destination = .addCategory(.init())
                return .none

            case .deleteCategory(let category):
                return .run { send in
                    try deleteCategoryUseCase.execute(category)
                    let categories = getCategoriesUseCase.execute()
                    await send(.categoriesLoaded(categories))
                }

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

            case .destination(.presented(.addCategory(.delegate(.categorySaved(let category))))):
                state.destination = nil
                return .run { send in
                    try addCategoryUseCase.execute(category)
                    let categories = getCategoriesUseCase.execute()
                    await send(.categoriesLoaded(categories))
                }

            case .destination(.presented(.addCategory(.delegate(.cancelTapped)))):
                state.destination = nil
                return .none
            
            case .binding, .delegate, .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
