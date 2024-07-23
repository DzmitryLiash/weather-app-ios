//
//  TemperatureState.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 23/07/2024.
//

import UIKit

enum TemperatureState {
    case hot
    case normal
    case cold
    
    init(temperature: Double) {
        switch temperature {
        case ..<10:
            self = .cold
        case 10...20:
            self = .normal
        default:
            self = .hot
        }
    }
    
    var color: UIColor {
        switch self {
        case .hot:
            return .red
        case .normal:
            return .black
        case .cold:
            return .blue
        }
    }
}
