
import SwiftUI
import ComposableArchitecture
import Domain

struct AddCategoryView: View {
    @Bindable var store: StoreOf<AddCategoryReducer>
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("카테고리 정보")) {
                    TextField("이름", text: $store.name)
                        .autocorrectionDisabled()
                    TextField("심볼", text: $store.symbol)
                        .autocorrectionDisabled()
                }
            }
            .navigationTitle("새 카테고리")
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
