//
//  ReuseIdentifier.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 21/07/2024.
//

import UIKit

public protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReuseIdentifier {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}
