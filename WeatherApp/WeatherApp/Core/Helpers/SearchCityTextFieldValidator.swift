//
//  SearchTextFieldValidator.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

struct SearchCityTextFieldValidator {
    private enum Constants {
        static let regexPattern = "^[A-Za-zżźćńółęąśŻŹĆĄŚĘŁÓŃ ]*$"
    }
    
    static func isValidInput(_ text: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: Constants.regexPattern) else {
            return false
        }
        
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex.firstMatch(in: text, range: range) != nil
    }
}
