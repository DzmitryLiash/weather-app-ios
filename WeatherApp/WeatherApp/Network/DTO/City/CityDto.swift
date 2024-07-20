//
//  CityDto.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

struct CityDto: Codable {
    let key: String
    let localizedName: String
    let region: LocalizedNameDto
    let country: LocalizedNameDto
    let administrativeArea: LocalizedNameDto
    
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
        case region = "Region"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }
}
