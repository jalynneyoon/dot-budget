
//
//  GetCategoriesUseCase.swift
//  Domain
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation

public final class GetCategoriesUseCase {
    private let categoryRepository: CategoryRepository

    public init(categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }

    public func execute() -> [Category] {
        return categoryRepository.getCategories()
    }
}
