//
//  City.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct City: Hashable {
    let key: String
    let localizedName: String
    let region: String
    let country: String
    let administrativeArea: String
}

extension City {
    static var emptyResult = City(
        key: "",
        localizedName: "",
        region: "",
        country: "",
        administrativeArea: ""
    )
}

extension City {
    init(dto: CityDto) {
        self.key = dto.key
        self.localizedName = dto.localizedName
        self.region = dto.region.localizedName
        self.country = dto.country.localizedName
        self.administrativeArea = dto.administrativeArea.localizedName
    }
}
