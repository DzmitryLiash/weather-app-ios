//
//  WeatherDetailsEndpoint.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

struct WeatherDetailsEndpoint: Endpoint {
    
    let locationKey: String
    
    var path: String {
        "/currentconditions/v1/\(locationKey)"
    }
    
    init(locationKey: String) {
        self.locationKey = locationKey
    }
    
    var parameters: [String: Any] {
        defaultParameters
    }
    
    typealias ResponseType = [WeatherDetailsDto]
}
