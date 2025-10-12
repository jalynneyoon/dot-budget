import SwiftUI
import Domain
import Shared
import Budget
import CoreTCA

public struct HomeView: View {
    let store: StoreOf<HomeReducer>

    public init(store: StoreOf<HomeReducer>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        SummaryCardView(
                            store: self.store.scope(state: \.summaryCard, action: \.summaryCard)
                        )
                        .padding(.horizontal)
                        
                        HeatmapView(
                            store: self.store.scope(state: \.heatmap, action: \.heatmap)
                        )
                        .padding(.vertical)
                        
                        Text("내역이 없습니다.")
                            .padding()
                    }
                }

                VStack {
                    Button(action: {
                        viewStore.send(.budgetButtonTapped)
                    }) {
                        Image(systemName: "dollarsign.circle")
                            .font(.title.weight(.semibold))
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4, x: 0, y: 4)
                    }
                    .padding()
                    
                    Button(action: {
                        viewStore.send(.fabButtonTapped)
                    }) {
                        Image(systemName: "plus")
                            .font(.title.weight(.semibold))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4, x: 0, y: 4)
                    }
                    .padding()
                }
            }
            .sheet(store: self.store.scope(state: \.$addExpense, action: \.addExpense)) { store in
                AddExpenseView(store: store)
            }
            .sheet(store: self.store.scope(state: \.$budget, action: \.budget)) { store in
                BudgetView(store: store)
            }
        }
    }
}

#Preview {
//     MockRepository를 사용하여 UseCase들을 생성하고 주입
    let mockCategoryRepo = MockCategoryRepository(
        initialCategories: [
            Category(id: UUID(), name: "식비", symbol: "fork.knife", isDefault: true),
            Category(id: UUID(), name: "교통", symbol: "car", isDefault: true),
            Category(id: UUID(), name: "생활", symbol: "house", isDefault: true),
            Category(id: UUID(), name: "문화", symbol: "music.note", isDefault: true),
            Category(id: UUID(), name: "기타", symbol: "ellipsis", isDefault: true)
        ]
    )

    let mockBudgetRepo = MockBudgetRepository(
        initialBudgets: [
            Budget(id: UUID(), monthKey: DateKeys.monthKey(from: .now), category: mockCategoryRepo.categories[0], amount: 500000),
            Budget(id: UUID(), monthKey: DateKeys.monthKey(from: .now), category: mockCategoryRepo.categories[1], amount: 100000)
        ]
    )
    
    let mockExpenseRepo = MockExpenseRepository(
        initialExpenses: [
            Expense(id: UUID(), date: Date().addingTimeInterval(-86400*20), amount: 25000, category: mockCategoryRepo.categories[0], memo: "Mock Expense 1", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now),
            Expense(id: UUID(), date: Date().addingTimeInterval(-86400*60), amount: 10000, category: mockCategoryRepo.categories[1], memo: "Mock Expense 2", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now),
            Expense(id: UUID(), date: Date().addingTimeInterval(-86400*1), amount: 3200, category: mockCategoryRepo.categories[0], memo: "Mock Expense 3", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now),
            Expense(id: UUID(), date: Date(), amount: 300000, category: mockCategoryRepo.categories[0], memo: "Mock Expense 4", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now),
            Expense(id: UUID(), date: Date(), amount: 200000, category: mockCategoryRepo.categories[0], memo: "Mock Expense 4", dayKey: 0, monthKey: 0, createdAt: .now, updatedAt: .now)


        ]
    )

    let addExpenseUseCase = AddExpenseUseCase(expenseRepository: mockExpenseRepo)
    let getMonthlySummaryUseCase = GetMonthlySummaryUseCase(expenseRepository: mockExpenseRepo, budgetRepository: mockBudgetRepo)
    let getHeatmapDataUseCase = GetHeatmapDataUseCase(expenseRepository: mockExpenseRepo)

    let getCategories = GetCategoriesUseCase(categoryRepository: mockCategoryRepo)
    let addCategory = AddCategoryUseCase(categoryRepository: mockCategoryRepo)
    let deleteCategory = DeleteCategoryUseCase(categoryRepository: mockCategoryRepo)
    let setBudget = SetBudgetUseCase(budgetRepository: mockBudgetRepo)
    let getBudgets = GetBudgetsUseCase(budgetRepository: mockBudgetRepo)
   

    withDependencies {
        $0.addExpenseUseCase = .init(execute: addExpenseUseCase.execute)
        $0.getMonthlySummaryUseCase = .init(execute: getMonthlySummaryUseCase.execute)
        $0.getHeatmapDataUseCase = .init(execute: getHeatmapDataUseCase.execute)
        $0.getCategoriesUseCase = .init(execute: getCategories.execute)
        $0.addCategoryUseCase = .init(execute: addCategory.execute)
        $0.deleteCategoryUseCase = .init(execute: deleteCategory.execute)
        $0.setBudgetUseCase = .init(execute: setBudget.execute)
        $0.getBudgetsUseCase = .init(execute: getBudgets.execute)
    } operation: {
        HomeView(
            store: Store(
                initialState: HomeReducer.State(),
                reducer: {
                    HomeReducer()
                }
            )
        )
    }
}
