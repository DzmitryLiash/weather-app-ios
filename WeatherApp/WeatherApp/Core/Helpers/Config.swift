//
//  Config.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 21/07/2024.
//

import Foundation

struct Config {
    static var baseURL: URL {
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let baseURL = URL(string: baseURLString) else {
            fatalError("Base URL is missing or empty in the Info.plist")
        }
        
        return baseURL
    }
    
    static var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API Key is missing or empty in the Info.plist")
        }
        
        return apiKey
    }
}
