//
//  AppError.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 23/07/2024.
//

import Foundation

enum AppError: LocalizedError {
    case noInternetConnection
    case apiError(String)
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString(
                "The Internet connection appears to be offline.",
                comment: "The Internet connection appears to be offline."
            )
        case let .apiError(message):
            return message
        case let .unknown(message):
            return message
        }
    }
    
    func errorInfo() -> (title: String, description: String) {
        switch self {
        case .noInternetConnection:
            return ("No network", "Check your internet connection")
        case .apiError:
            return ("API Error", "An error occurred while communicating with the server")
        case let .unknown(message):
            return ("Unknown error", message)
        }
    }
}
