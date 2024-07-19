//
//  BaseView.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 19/07/2024.
//

import UIKit

class BaseView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        setupSubviews()
    }
    
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {}
    
    func setupConstraints() {}
    
    func setupSubviews() {}
}
