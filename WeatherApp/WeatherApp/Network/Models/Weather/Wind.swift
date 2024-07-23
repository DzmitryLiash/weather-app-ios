//
//  Wind.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

struct Wind {
    let direction: DirectionDto
    let speed: MeasureDto
}

extension Wind {
    init(dto: WindDto) {
        self.direction = dto.direction
        self.speed = dto.speed
    }
}
