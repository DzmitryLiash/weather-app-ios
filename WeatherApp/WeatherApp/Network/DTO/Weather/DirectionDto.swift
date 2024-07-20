//
//  DirectionDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct DirectionDto: Codable {
    let localized: String
    
    enum CodingKeys: String, CodingKey {
        case localized = "Localized"
    }
}
