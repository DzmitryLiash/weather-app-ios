//
//  TemperatureDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct MeasureDto: Codable {
    let metric: UnitDto
    let imperial: UnitDto

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}
