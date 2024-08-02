//
//  Item.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import Foundation
import SwiftData

@Model
final class ShoppingList {
    var store: String?
    var shoppingList: [Product]
    
    init(store: String? = nil, shoppingList: [Product]) {
        self.store = store
        self.shoppingList = shoppingList
    }
}

struct Product : Codable, Identifiable, Hashable{
    let name: String
    let price: Int
    let image: Data?
    
    var id: UUID {
        return UUID()
    }
}
