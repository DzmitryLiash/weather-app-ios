//
//  Temperature.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct Measure {
    let metric: Unit
    let imperial: Unit
}

extension Measure {
    init(dto: MeasureDto) {
        self.metric = Unit(dto: dto.metric)
        self.imperial = Unit(dto: dto.imperial)
    }
}
