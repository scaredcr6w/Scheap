//
//  JSONParser.swift
//  Scheap
//
//  Created by Anda Levente on 26/07/2024.
//

import Foundation
struct Product : Codable, Identifiable{
    let brand: String
    let name: String
    let category: String
    let price: Int
    let image: Data?
    
    var id: UUID {
        return UUID()
    }
}

final class JSONParser : ObservableObject {
    func loadData() async throws -> [Product] {
        guard let url = URL(string: "http://localhost:3000/products") else {
            fatalError("Invalid URL!")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            fatalError("Failed to decode productlist.json from bundle: \(error)")
        }
    }
}
