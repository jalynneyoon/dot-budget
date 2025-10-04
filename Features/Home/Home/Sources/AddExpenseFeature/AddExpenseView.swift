
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
                
                Section(header: Text("카테고리 관리")) {
                    ForEach(store.categories, id: \.self) { category in
                        HStack {
                            Text(category.name)
                            Spacer()
                            Button(role: .destructive) {
                                store.send(.deleteCategory(category))
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    
                    Button("새 카테고리 추가") {
                        store.send(.addCategoryButtonTapped)
                    }
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
            .onAppear {
                store.send(.onAppear)
            }
            .sheet(item: $store.scope(state: \.destination?.addCategory, action: \.destination.addCategory)) { store in
                AddCategoryView(store: store)
            }
        }
    }
    
}


#Preview {
    AddExpenseView(
        store: .init(
            initialState: AddExpenseReducer.State(),
            reducer: AddExpenseReducer.init
        )
    )
}
