//
//  LocalizedNameDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct LocalizedNameDto: Codable {
    let localizedName: String

    enum CodingKeys: String, CodingKey {
        case localizedName = "LocalizedName"
    }
}
