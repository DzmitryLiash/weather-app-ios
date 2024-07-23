//
//  WeatherDetailsDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

struct WeatherDetailsDto: Codable {
    let weatherText: String
    let weatherIcon: Int
    let temperature: MeasureDto
    let realFeelTemperature: MeasureDto
    let wind: WindDto
    let uvIndex: Int
    let uvIndexText: String
    let visibility: MeasureDto
    let cloudCover: Int
    let pressure: MeasureDto
    
    enum CodingKeys: String, CodingKey {
        case weatherText = "WeatherText"
        case temperature = "Temperature"
        case weatherIcon = "WeatherIcon"
        case realFeelTemperature = "RealFeelTemperature"
        case wind = "Wind"
        case uvIndex = "UVIndex"
        case uvIndexText = "UVIndexText"
        case visibility = "Visibility"
        case cloudCover = "CloudCover"
        case pressure = "Pressure"
    }
}
