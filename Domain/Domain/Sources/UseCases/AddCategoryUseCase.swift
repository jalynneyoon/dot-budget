
//
//  AddCategoryUseCase.swift
//  Domain
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation

public final class AddCategoryUseCase {
    private let categoryRepository: CategoryRepository

    public init(categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }

    public func execute(_ category: Category) throws {
        try categoryRepository.addCategory(category)
    }
}
