import SwiftUI
import Domain
import CoreTCA

struct SummaryCardView: View {
    @Bindable var store: StoreOf<SummaryCardReducer>

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if store.isLoading {
                ProgressView()
            } else if let error = store.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else if let summary = store.summary {
                Text("이번 달 총 예산: \(summary.totalBudget)원")
                    .font(.headline)
                Text("이번 달 총 지출: \(summary.totalExpense)원")
                    .font(.headline)
                
                Divider()
                
                ForEach(summary.categorySummaries, id: \.category.id) { categorySummary in
                    HStack {
                        Text(categorySummary.category.name)
                        Spacer()
                        Text("\(categorySummary.spentAmount) / \(categorySummary.budgetAmount)원")
                        Text("(\(categorySummary.remainingAmount)원 남음)")
                            .font(.caption)
                            .foregroundColor(categorySummary.remainingAmount < 0 ? .red : .green)
                    }
                }
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
