//
//  MockCategoryRepository.swift
//  Home
//
//  Created by JohyeonYoon on 10/4/25.
//

import Foundation
import Domain

final class MockCategoryRepository: CategoryRepository {
    
    var categories: [Domain.Category]
    
    init(initialCategories: [Domain.Category] = []) {
        self.categories = initialCategories
    }
    
    func getCategories() -> [Domain.Category] {
        return categories
    }
    
    func addCategory(_ category: Domain.Category) throws {
        categories.append(category)
    }
    
    func deleteCategory(_ category: Domain.Category) throws {
        categories.removeAll { $0.id == category.id }
    }
}
