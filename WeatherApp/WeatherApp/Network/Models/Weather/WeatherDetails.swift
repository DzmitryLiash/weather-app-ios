//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct WeatherDetails {
    let weatherText: String
    let temperature: Temperature
    let realFeelTemperature: Temperature
    let wind: Wind
}

extension WeatherDetails {
    init(dto: WeatherDetailsDto) {
        self.weatherText = dto.weatherText
        self.temperature = Temperature(dto: dto.temperature)
        self.realFeelTemperature = Temperature(dto: dto.realFeelTemperature)
        self.wind = Wind(dto: dto.wind)
    }
}
