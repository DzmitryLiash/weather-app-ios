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
    case serviceUnavailable(String)
    case unauthorized(String)
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString(
                "The Internet connection appears to be offline.",
                comment: "The Internet connection appears to be offline."
            )
        case let .apiError(message),
             let .serviceUnavailable(message),
             let .unauthorized(message),
             let .unknown(message):
             return message
        }
    }
    
    func errorInfo() -> (title: String, description: String) {
        switch self {
        case .noInternetConnection:
            return ("No network", "Check your internet connection")
        case .apiError:
            return ("API Error", "An error occurred while communicating with the server")
        case let .serviceUnavailable(message):
            return ("Service Unavailable", message)
        case let .unauthorized(message):
            return ("Unauthorized", message)
        case let .unknown(message):
            return ("Unknown error", message)
        }
    }
}

extension AppError {
    init(apiErrorResponse: APIErrorResponseDto) {
        switch apiErrorResponse.code {
        case .serviceUnavailable:
            self = .serviceUnavailable(apiErrorResponse.message)
        case .unauthorized:
            self = .unauthorized(apiErrorResponse.message)
        case .unknown:
            self = .apiError(apiErrorResponse.message)
        }
    }
}
