//
//  JSONParser.swift
//  Scheap
//
//  Created by Anda Levente on 26/07/2024.
//

import Foundation

enum ParsingErrors: Error, LocalizedError {
    case invalidUrl
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Helytelen URL!"
        case .decodingError:
            return "Valami hiba történt a dekódolás során!"
        }
    }
}

final class JSONParser : ObservableObject {
    func loadData(from url: String) async throws -> [Product] {
        guard let url = URL(string: url) else {
            throw ParsingErrors.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            throw ParsingErrors.decodingError
        }
    }
}
