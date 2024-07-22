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
    @Published var userList: String = ""
    
    func setUserList(userInput: String) {
        userList = userInput
        print(userList)
    }
    
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
        
        guard userList.rangeOfCharacter(from: validCharacters) != nil else {
            completionHandler(.failure(.specialCharacters))
            return
        }

        completionHandler(.success(userInput))
    }
    
    func handleUserInput(completion: @escaping (Error?) -> Void) {
        validateUserInput(from: userList) { result in
            switch result {
            case .success(let validString):
                self.userList = validString
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
