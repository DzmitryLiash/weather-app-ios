//
//  UnitDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct UnitDto: Codable {
    let value: Double
    let unit: String
    let phrase: String?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case phrase = "Phrase"
    }
}
