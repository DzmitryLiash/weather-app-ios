//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Combine

protocol WeatherAPI: APIClient {
    func fetchCities(with query: String) -> AnyPublisher<[City], AppError>
    func fetchCityWeather(with locationKey: String) -> AnyPublisher<[WeatherDetails], AppError>
}

struct WeatherAPIService: WeatherAPI {
    func fetchCities(with query: String) -> AnyPublisher<[City], AppError> {
        let endpoint = CitiesSearchEndpoint(query: query)
        
        return fetch(endpoint: endpoint)
            .mapMany(City.init)
            .eraseToAnyPublisher()
    }
    
    func fetchCityWeather(with locationKey: String) -> AnyPublisher<[WeatherDetails], AppError> {
        let endpoint = WeatherDetailsEndpoint(locationKey: locationKey)
        
        return fetch(endpoint: endpoint)
            .mapMany(WeatherDetails.init)
            .eraseToAnyPublisher()
    }
}
