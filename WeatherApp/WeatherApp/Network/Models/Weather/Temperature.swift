//
//  Temperature.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct Temperature {
    let metric: Unit
    let imperial: Unit
}

extension Temperature {
    init(dto: TemperatureDto) {
        self.metric = Unit(dto: dto.metric)
        self.imperial = Unit(dto: dto.imperial)
    }
}
