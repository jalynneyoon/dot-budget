
import Foundation
import Domain
import Shared

public class MockExpenseRepository: ExpenseRepository {
    public var expenses: [Expense]
    public var budgets: [Budget]

    public init(initialExpenses: [Expense] = [], initialBudgets: [Budget] = []) {
        self.expenses = initialExpenses
        self.budgets = initialBudgets
    }

    public func addExpense(_ expense: Expense) async throws {
        expenses.append(expense)
        print("Mock: Added expense: \(expense.amount) on \(expense.date)")
    }

    public func getMonthlyExpenses(for date: Date) async throws -> [Expense] {
        let calendar = Calendar.current
        let monthKey = DateKeys.monthKey(from: date, calendar: calendar)
        return expenses.filter { DateKeys.monthKey(from: $0.date, calendar: calendar) == monthKey }
    }

    public func getBudget(for date: Date) async throws -> Budget? {
        let calendar = Calendar.current
        let monthKey = DateKeys.monthKey(from: date, calendar: calendar)
        return budgets.first(where: { DateKeys.monthKey(from: $0.monthKeyDate, calendar: calendar) == monthKey })
    }

    public func getDailyExpenses(for date: Date, in interval: DateInterval) async throws -> [Expense] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: interval.start)
        let endOfDay = calendar.startOfDay(for: interval.end)
        return expenses.filter { $0.date >= startOfDay && $0.date < endOfDay }
    }
}

// Helper for Budget model to get date from monthKey
extension Budget {
    var monthKeyDate: Date {
        let year = monthKey / 100
        let month = monthKey % 100
        var components = DateComponents()
        components.year = year
        components.month = month
        return Calendar.current.date(from: components) ?? Date()
    }
}
