//
//  StringExtensions.swift
//  Scheap
//
//  Created by Anda Levente on 29/07/2024.
//

import Foundation

extension String {
    var withoutSpecialChars: String {
        return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
    }
}
