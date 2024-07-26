//
//  Item.swift
//  Scheap
//
//  Created by Anda Levente on 18/07/2024.
//

import Foundation
import SwiftData

enum ProductCategory : Codable {
    case dairy
    case meat
    case fruitvegetable
    case pastries
    case frozen
    case housekeping
    case petfood
    case baseProducts
    case baby
    case beauty
    case snack
    case vegan
    case beverage
    case alcoholicBeverage
    case other
}

@Model
final class ShoppingList {
    var shoppingList: [Product]
    
    init(shoppingList: [Product]) {
        self.shoppingList = shoppingList
    }
}
