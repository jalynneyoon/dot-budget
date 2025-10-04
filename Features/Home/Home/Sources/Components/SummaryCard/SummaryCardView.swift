import SwiftUI
import ComposableArchitecture
import Domain
import Dependencies

struct SummaryCardView: View {
    @Bindable var store: StoreOf<SummaryCardReducer>

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if store.isLoading {
                ProgressView()
            } else if let error = store.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Text("이번 달 총 지출: \(store.totalExpense)원")
                    .font(.headline)
                
                Text("예산 대비: \(String(format: "%.1f", store.budgetPercentage))%")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(store.feedbackMessage)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    SummaryCardView(
        store: Store(initialState: SummaryCardReducer.State()) {
            SummaryCardReducer()
        }
    )
}
