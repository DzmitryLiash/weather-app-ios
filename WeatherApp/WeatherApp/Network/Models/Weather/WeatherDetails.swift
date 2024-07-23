//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct WeatherDetails {
    let weatherText: String
    let weatherIcon: Int
    let temperature: Measure
    let realFeelTemperature: Measure
    let wind: Wind
    let uvIndex: String
    let uvIndexText: String
    let visibility: Measure
    let cloudCover: String
    let pressure: Measure
}

extension WeatherDetails {
    init(dto: WeatherDetailsDto) {
        self.weatherText = dto.weatherText
        self.weatherIcon = dto.weatherIcon
        self.temperature = Measure(dto: dto.temperature)
        self.realFeelTemperature = Measure(dto: dto.realFeelTemperature)
        self.wind = Wind(dto: dto.wind)
        self.uvIndex = String(dto.uvIndex)
        self.uvIndexText = dto.uvIndexText
        self.visibility = Measure(dto: dto.visibility)
        self.cloudCover = String(dto.cloudCover) + "%"
        self.pressure = Measure(dto: dto.pressure)
    }
}
