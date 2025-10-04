
//
//  CategoryRepository.swift
//  Domain
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation

public protocol CategoryRepository {
    func getCategories() -> [Category]
    func addCategory(_ category: Category) throws
    func deleteCategory(_ category: Category) throws
}
