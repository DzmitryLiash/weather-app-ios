//
//  Unit.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct Unit {
    let value: Double
    let unit: String
    let phrase: String?
}

extension Unit {
    init(dto: UnitDto) {
        self.value = dto.value
        self.unit = dto.unit
        self.phrase = dto.phrase
    }
}
