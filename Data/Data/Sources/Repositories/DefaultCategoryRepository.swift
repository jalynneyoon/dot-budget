
//
//  DefaultCategoryRepository.swift
//  Data
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation
import Domain
import SwiftData

public final class DefaultCategoryRepository: CategoryRepository {
    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func getCategories() -> [Category] {
        let descriptor = FetchDescriptor<CategoryEntity>()
        do {
            let entities = try modelContext.fetch(descriptor)
            return entities.map { $0.toDomain() }
        } catch {
            // Handle error
            return []
        }
    }

    public func addCategory(_ category: Category) throws {
        let categoryEntity = category.toEntity()
        modelContext.insert(categoryEntity)
    }

    public func deleteCategory(_ category: Category) throws {
        let predicate = #Predicate<CategoryEntity> { $0.id == category.id }
        let descriptor = FetchDescriptor<CategoryEntity>(predicate: predicate)
        
        if let entity = try modelContext.fetch(descriptor).first {
            modelContext.delete(entity)
        }
    }
}
