//
//  CitiesSearchEndpoint.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

struct CitiesSearchEndpoint: Endpoint {
    
    let additionalParameters: [String: Any]

    var path: String {
        "/locations/v1/cities/search"
    }
    
    init(query: String) {
        self.additionalParameters = ["q": query]
    }
    
    var parameters: [String : Any] {
        var parameters = defaultParameters
        additionalParameters.forEach { parameters[$0.key] = $0.value }
        return parameters
    }
    
    typealias ResponseType = [CityDto]
}
