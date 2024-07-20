//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any] { get }
    
    associatedtype ResponseType: Decodable
}

extension Endpoint {
    var baseURL: URL {
        guard let url = AccuweatherConfigManager.baseURL else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }
    
    var method: HTTPRequestMethod {
        .get
    }
    
    var headers: [String: String]? {
        ["Accept-Encoding": "gzip"]
    }
    
    var defaultParameters: [String: Any] {
        ["apikey": AccuweatherConfigManager.apiKey, "details": true]
    }
}
