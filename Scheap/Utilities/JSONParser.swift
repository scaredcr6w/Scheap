//
//  JSONParser.swift
//  Scheap
//
//  Created by Anda Levente on 26/07/2024.
//

import Foundation
struct Product : Codable, Identifiable{
    var id = UUID()
    let brand: String?
    let name: String
    let category: String
    let price: Int?
    let image: Data?
}

final class JSONParser : ObservableObject {
    func loadData() async throws -> [Product] {
        guard let url = URL(string: "http://localhost:3000/products") else {
            fatalError("Helytelen URL!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load productlist.json from bundle.")
        }
        
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            fatalError("Failed to decode productlist.json from bundle.")
        }
        
        return products
    }
}
