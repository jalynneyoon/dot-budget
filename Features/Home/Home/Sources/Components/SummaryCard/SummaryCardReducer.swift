
import ComposableArchitecture
import Foundation
import Domain

@Reducer
struct SummaryCardReducer {
    @ObservableState
    struct State: Equatable {
        var totalExpense: Int = 0
        var budgetPercentage: Double = 0
        var feedbackMessage: String = ""
        var isLoading: Bool = false
        var error: String? = nil
        var currentDate: Date = .now // For which month to display summary
    }

    enum Action {
        case onAppear
        case summaryResponse(TaskResult<MonthlySummary>)
    }

    @Dependency(\.getMonthlySummaryUseCase) var getMonthlySummaryUseCase

    var body: some ReducerOf<Self> {
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
                state.totalExpense = summary.totalExpense
                state.budgetPercentage = summary.budgetPercentage
                state.feedbackMessage = summary.feedbackMessage
                return .none

            case let .summaryResponse(.failure(error)):
                state.isLoading = false
                state.error = error.localizedDescription
                return .none
            }
        }
    }
}
