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
    var shoppingItems: [String] = []
    
    
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
        validateUserInput(from: userListInput) { result in
            switch result {
            case .success(let validString):
                self.shoppingItems = self.stringToArray(input: validString)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    private func stringToArray(input: String) -> [String] {
        return input.split(separator: "\n").map(String.init)
    }
}
