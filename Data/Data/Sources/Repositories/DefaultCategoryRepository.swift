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

    public func getCategories() -> [Domain.Category] {
        let descriptor = FetchDescriptor<CategoryEntity>()
        do {
            let entities = try modelContext.fetch(descriptor)
            return entities.map { $0.toDomain() }
        } catch {
            // Handle error
            return []
        }
    }

    public func addCategory(_ category: Domain.Category) throws {
        let categoryEntity: CategoryEntity = category.toEntity()
        modelContext.insert(categoryEntity)
    }

    public func deleteCategory(_ category: Domain.Category) throws {
        let id = category.id
        let predicate = #Predicate<CategoryEntity> { entity in
            entity.id == id
        }
        let descriptor = FetchDescriptor<CategoryEntity>(predicate: predicate)
        
        if let entity = try modelContext.fetch(descriptor).first {
            modelContext.delete(entity)
        }
    }
}
