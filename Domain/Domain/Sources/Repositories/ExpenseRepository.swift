
//
//  ExpenseRepository.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public protocol ExpenseRepository {
    func addExpense(_ expense: Expense) async throws
}
