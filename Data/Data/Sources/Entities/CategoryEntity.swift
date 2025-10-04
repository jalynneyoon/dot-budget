//
//  CategoryEntity.swift
//  Data
//
//  Created by JohyeonYoon on 10/3/25.
//

import Foundation
import SwiftData
import Domain

@Model
public final class CategoryEntity {
    @Attribute(.unique) public let id: UUID
    public let name: String
    public let symbol: String
    public let isDefault: Bool
    
    public init(id: UUID, name: String, symbol: String, isDefault: Bool) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.isDefault = isDefault
    }
}

extension CategoryEntity {
    func toDomain() -> Category {
        return Category(id: id, name: name, symbol: symbol, isDefault: isDefault)
    }
}

extension Category {
    func toEntity() -> CategoryEntity {
        return CategoryEntity(id: id, name: name, symbol: symbol, isDefault: isDefault)
    }
}