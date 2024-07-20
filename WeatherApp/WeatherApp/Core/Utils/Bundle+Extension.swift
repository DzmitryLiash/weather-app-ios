//
//  Bundle+Extension.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

extension Bundle {

    var baseURL: String {
        string(for: "BASE_URL")
    }
    
    private func string(for key: String) -> String {
        let object = object(forInfoDictionaryKey: key) as AnyObject
        return object.description ?? ""
    }
}
