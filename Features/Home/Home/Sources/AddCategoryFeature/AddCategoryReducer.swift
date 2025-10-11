import Foundation
import Domain
import CoreTCA

@Reducer
public struct AddCategoryReducer {
    @ObservableState
    public struct State: Equatable {
        var name: String = ""
        var symbol: String = ""
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case cancelButtonTapped
        case saveButtonTapped
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case categorySaved(Domain.Category)
            case cancelTapped
        }
    }

    public var body: some ReducerOf<Self> {
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
