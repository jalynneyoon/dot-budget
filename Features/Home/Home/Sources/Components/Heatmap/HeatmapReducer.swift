
import Foundation
import Domain
import CoreTCA

@Reducer
public struct HeatmapReducer {
    @ObservableState
    public struct State: Equatable {
        var heatmapData: [Date: Int] = [:]
        var isLoading: Bool = false
        var error: String? = nil
        var currentMonth: Date = .now // Month for which to display heatmap
    }

    public enum Action: Equatable {
        case onAppear
        case heatmapDataResponse(TaskResult<[Date: Int]>)
    }

    @Dependency(\.getHeatmapDataUseCase) var getHeatmapDataUseCase

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                state.error = nil
                return .run { [month = state.currentMonth] send in
                    await send(.heatmapDataResponse(TaskResult {
                        try await getHeatmapDataUseCase.execute(month)
                    }))
                }

            case let .heatmapDataResponse(.success(data)):
                state.isLoading = false
                state.heatmapData = data
                return .none

            case let .heatmapDataResponse(.failure(error)):
                state.isLoading = false
                state.error = error.localizedDescription
                return .none
            }
        }
    }
}
