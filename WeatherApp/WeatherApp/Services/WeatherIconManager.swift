//
//  WeatherIconManager.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 23/07/2024.
//

import UIKit

protocol WeatherIconProviding {
    func getWeatherIcon(for number: Int) -> UIImage?
}

class WeatherIconManager: WeatherIconProviding {
    func getWeatherIcon(for number: Int) -> UIImage? {
        let iconName = "\(number)"
        return UIImage(named: iconName)
    }
}
