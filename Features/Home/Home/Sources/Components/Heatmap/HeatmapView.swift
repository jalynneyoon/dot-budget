
import SwiftUI
import ComposableArchitecture

struct HeatmapView: View {
    @Bindable var store: StoreOf<HeatmapReducer>
    
    private let calendar = Calendar.current
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7) // 7 days a week

    var body: some View {
        VStack(alignment: .leading) {
            Text("이번 달 지출")
                .font(.headline)
                .padding(.horizontal)

            if store.isLoading {
                ProgressView()
            } else if let error = store.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(daysInMonth(), id: \.self) { day in
                        if let day = day {
                            let totalExpense = store.heatmapData[calendar.startOfDay(for: day)] ?? 0
                            Rectangle()
                                .fill(color(for: totalExpense))
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
    
    private func daysInMonth() -> [Date?] {
        guard let interval = calendar.dateInterval(of: .month, for: store.currentMonth) else { return [] }
        
        var days: [Date?] = []
        
        // Add leading empty days for alignment
        let firstWeekday = calendar.component(.weekday, from: interval.start)
        for _ in 1..<firstWeekday {
            days.append(nil)
        }
        
        // Add days of the month
        calendar.enumerateDates(startingAfter: interval.start, matching: .init(hour: 0), matchingPolicy: .nextTime) { date, _, stop in
            guard let date = date, interval.contains(date) else { stop = true; return }
            days.append(date)
        }
        return days
    }
    
    private func color(for expense: Int) -> Color {
        if expense == 0 { return Color.gray.opacity(0.2) }
        if expense < 10000 { return Color.green.opacity(0.3) }
        if expense < 50000 { return Color.green.opacity(0.6) }
        if expense < 100000 { return Color.green.opacity(0.8) }
        return Color.green // Darkest green
    }
}

#Preview {
    HeatmapView(
        store: Store(initialState: HeatmapReducer.State()) {
            HeatmapReducer()
        }
    )
}
