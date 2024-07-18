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
    case fruit
    case vegetable
    case beverage
    case alcoholicBeverage
    case other
}

@Model
final class Product {
    var manufacturer: String
    var name: String
    var category: ProductCategory
    var price: Int
    var image: Data?
    
    init(manufacturer: String, name: String, category: ProductCategory, price: Int, image: Data? = nil) {
        self.manufacturer = manufacturer
        self.name = name
        self.category = category
        self.price = price
        self.image = image
    }
}
