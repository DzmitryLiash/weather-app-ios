//
//  WeatherIconProvider.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 23/07/2024.
//

import UIKit

struct WeatherIconProvider {
    static func getWeatherIcon(for number: Int) -> UIImage? {
        let iconName = "\(number)"
        return UIImage(named: iconName)
    }
}
