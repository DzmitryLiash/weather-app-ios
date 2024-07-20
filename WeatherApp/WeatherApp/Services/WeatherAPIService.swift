//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Combine

protocol WeatherAPI: APIClient {
    func fetchCities(with query: String) -> AnyPublisher<[City], Error>
    func fetchCityWeather(with locationKey: String) -> AnyPublisher<[WeatherDetails], Error>
}

struct WeatherAPIService: WeatherAPI {
    func fetchCities(with query: String) -> AnyPublisher<[City], Error> {
        let endpoint = CitiesSearchEndpoint(query: query)
        
        return fetch(endpoint: endpoint)
            .mapMany(City.init)
            .eraseToAnyPublisher()
    }
    
    func fetchCityWeather(with locationKey: String) -> AnyPublisher<[WeatherDetails], Error> {
        let endpoint = WeatherDetailsEndpoint(locationKey: locationKey)
        
        return fetch(endpoint: endpoint)
            .mapMany(WeatherDetails.init)
            .eraseToAnyPublisher()
    }
}
