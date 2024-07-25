//
//  APIErrorResponseCode.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 25/07/2024.
//

enum APIErrorResponseCode: String, Decodable {
    case serviceUnavailable = "ServiceUnavailable"
    case unauthorized = "Unauthorized"
    case unknown
}
