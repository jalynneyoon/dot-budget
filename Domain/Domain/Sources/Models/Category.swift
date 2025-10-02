
//
//  Category.swift
//  Domain
//
//  Created by JohyeonYoon on 10/2/25.
//

import Foundation

public struct Category: Hashable {
    public let id: UUID
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
