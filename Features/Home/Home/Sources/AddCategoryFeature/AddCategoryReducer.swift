
import ComposableArchitecture
import Foundation
import Domain

@Reducer
struct AddCategoryReducer {
    @ObservableState
    struct State: Equatable {
        var name: String = ""
        var symbol: String = ""
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case cancelButtonTapped
        case saveButtonTapped
        case delegate(Delegate)
        
        enum Delegate {
            case categorySaved(Domain.Category)
            case cancelTapped
        }
    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .saveButtonTapped:
                let newCategory = Category(
                    id: UUID(),
                    name: state.name,
                    symbol: state.symbol,
                    isDefault: false
                )
                return .send(.delegate(.categorySaved(newCategory)))

            case .cancelButtonTapped:
                return .send(.delegate(.cancelTapped))

            case .binding, .delegate:
                return .none
            }
        }
    }
}
