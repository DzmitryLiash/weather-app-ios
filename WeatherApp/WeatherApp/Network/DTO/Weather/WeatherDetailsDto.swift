//
//  WeatherDetailsDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

struct WeatherDetailsDto: Codable {
    let weatherText: String
    let temperature: TemperatureDto
    let realFeelTemperature: TemperatureDto
    let wind: WindDto
    
    
    enum CodingKeys: String, CodingKey {
        case weatherText = "WeatherText"
        case temperature = "Temperature"
        case realFeelTemperature = "RealFeelTemperature"
        case wind = "Wind"
    }
}
