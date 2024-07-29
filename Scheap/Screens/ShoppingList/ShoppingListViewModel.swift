//
//  ShoppingListViewModel.swift
//  Scheap
//
//  Created by Anda Levente on 22/07/2024.
//

import Foundation

enum ShoppingListValidationError : Error, LocalizedError {
    case emptyInput
    case specialCharacters
    
    var errorDescription: String? {
        switch self {
        case .emptyInput:
            return "A lista nem lehet üres!"
        case .specialCharacters:
            return "A lista nem tartalmazhat speciális karaktereket!"
        }
    }
}

final class ShoppingListViewModel : ObservableObject {
    @Published var userListInput: String = ""
    @Published var cheapestLists: [ShoppingList] = []
    private var jsonParser = JSONParser()
    var shoppingItems: [String] = []
    var storeInventory: [Product] = []
    
    
    private func validateUserInput(
        from userInput: String,
        completionHandler: @escaping (Result<String,ShoppingListValidationError>) -> Void
    ) {
        var validCharacters = CharacterSet.alphanumerics
        validCharacters.insert(charactersIn: "\n")
        
        guard userInput != "" else {
            completionHandler(.failure(.emptyInput))
            return
        }
        
        guard userListInput.rangeOfCharacter(from: validCharacters) != nil else {
            completionHandler(.failure(.specialCharacters))
            return
        }
        
        completionHandler(.success(userInput))
    }
    
    func handleUserInput(completion: @escaping (Error?) -> Void) {
        validateUserInput(from: userListInput) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let validString):
                self.shoppingItems = self.stringToArrayLowercased(input: validString, sep: "\n")
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    private func stringToArrayLowercased(input: String, sep: String) -> [String] {
        return input.split(separator: sep).map { $0.lowercased() }
    }
    
    func createCheapestList(from store: String) async throws -> ShoppingList {
        var cheapestOption: [Product] = []
        
        do {
            shoppingItems = stringToArrayLowercased(input: userListInput, sep: "\n")
            storeInventory = try await jsonParser.loadData(from: "http://localhost:3000/products")
        } catch {
            throw ParsingErrors.decodingError
        }
        
        for item in shoppingItems {
            if let cheapestProduct = searchItemVariations(for: item).min(by: { $0.price < $1.price }) {
                cheapestOption.append(cheapestProduct)
            }
        }
        
        print(cheapestOption)
        return ShoppingList(store: store, shoppingList: cheapestOption)
    }
    
    private func searchItemVariations(for item: String) -> [Product] {
        let currentItem: [String] = stringToArrayLowercased(input: item.withoutSpecialChars, sep: " ")
        var matchingProducts: [Product] = []
        
        // végigmegy az összes terméken, majd ellenőrzi, hogy a jelenlegi input tömbben benne van e a termék neve tömbben
        for product in storeInventory {
            let productNameArray: [String] = stringToArrayLowercased(input: product.name.withoutSpecialChars, sep: " ")
            let containsItem: Bool = productNameArray.contains { item in
                currentItem.contains(item)
            }
            
            if containsItem {
                let match: Bool = currentItem.allSatisfy { productNameArray.contains($0) }
                
                if match {
                    matchingProducts.append(product)
                }
            }
        }
        
        return matchingProducts
    }
}
