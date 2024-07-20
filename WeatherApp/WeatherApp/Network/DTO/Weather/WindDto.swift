//
//  WindDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct WindDto: Codable {
    let direction: DirectionDto
    let speed: TemperatureDto
    
    enum CodingKeys: String, CodingKey {
        case direction = "Direction"
        case speed = "Speed"
    }
}
