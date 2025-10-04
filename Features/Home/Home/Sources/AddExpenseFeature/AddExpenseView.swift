import SwiftUI
import ComposableArchitecture
import Domain

struct AddExpenseView: View {
    @Bindable var store: StoreOf<AddExpenseReducer>
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("지출 정보")) {
                    TextField("금액", text: $store.amount)
                        .keyboardType(.numberPad)
                        .autocorrectionDisabled()
                    
                    Picker("카테고리", selection: $store.selectedCategory) {
                        Text("미선택").tag(nil as Domain.Category?)
                        ForEach(store.categories, id: \.self) { category in
                            Text(category.name).tag(category as Domain.Category?)
                        }
                    }
                    
                    DatePicker(
                        "날짜",
                        selection: $store.expenseDate,
                        displayedComponents: .date
                    )
                    
                    TextField("메모 (선택사항)", text: $store.memo)
                }
            }
            .navigationTitle("지출 기록")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") { store.send(.cancelButtonTapped) }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") { store.send(.saveButtonTapped) }
                }
            }
        }
    }
    
}
