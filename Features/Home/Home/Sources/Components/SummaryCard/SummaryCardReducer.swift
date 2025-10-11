import Foundation
import Domain
import CoreTCA

@Reducer
public struct SummaryCardReducer {
    @ObservableState
    public struct State: Equatable {
        var summary: MonthlySummary?
        var isLoading: Bool = false
        var error: String? = nil
        var currentDate: Date = .now // For which month to display summary
    }

    public enum Action: Equatable {
        case onAppear
        case summaryResponse(TaskResult<MonthlySummary>)
    }

    @Dependency(\.getMonthlySummaryUseCase) var getMonthlySummaryUseCase

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                state.error = nil
                return .run { [date = state.currentDate] send in
                    await send(.summaryResponse(TaskResult { 
                        try await getMonthlySummaryUseCase.execute(date) 
                    }))
                }

            case let .summaryResponse(.success(summary)):
                state.isLoading = false
                state.summary = summary
                return .none

            case let .summaryResponse(.failure(error)):
                state.isLoading = false
                state.error = error.localizedDescription
                return .none
            }
        }
    }
}
