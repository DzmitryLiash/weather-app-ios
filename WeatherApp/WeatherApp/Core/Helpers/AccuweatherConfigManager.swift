//
//  AccuweatherConfigManager.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 21/07/2024.
//

import Foundation

struct AccuweatherConfigManager {
    
    static var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Accuweather-Info", ofType: "plist") else {
           fatalError("Couldn't find file 'Accuweather-Info.plist'.")
         }
         
         let plist = NSDictionary(contentsOfFile: filePath)
         guard let value = plist?.object(forKey: "API_KEY") as? String else {
             fatalError("Couldn't find key 'API_KEY' in 'Accuweather-Info.plist'.")
         }
         
         if (value.starts(with: "_")) {
           fatalError("Register for a accuweather developer account and get an API key at https://developer.accuweather.com")
         }
    
         return value
    }
    
    static var baseURL: URL? {
       return URL(string: Bundle.main.baseURL)
    }
}
