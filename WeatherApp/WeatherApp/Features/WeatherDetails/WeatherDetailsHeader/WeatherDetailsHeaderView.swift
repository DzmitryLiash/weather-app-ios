//
//  WeatherDetailsHeaderView.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 23/07/2024.
//

import UIKit

final class WeatherDetailsHeaderView: BaseView {
    
    private enum Constants {
        static let temperatureLabelFont: UIFont = UIFont(name: AppFont.interBold, size: 54) ?? .boldSystemFont(ofSize: 54)
        static let placeLabelFont: UIFont = UIFont(name: AppFont.interMedium, size: 18) ?? .systemFont(ofSize: 18, weight: .medium)
        static let weatherTextLabelFont: UIFont = UIFont(name: AppFont.interRegular, size: 14) ?? .systemFont(ofSize: 14, weight: .ultraLight)
        static let stackViewSpacing: CGFloat = 4
        static let weatherStackViewSpacing: CGFloat = 4
        static let stackViewTop: CGFloat = 20
        static let stackViewBottom: CGFloat = -20
        static let weatherIconImageViewSize: CGFloat = 40
    }

    private let temperatureLabel = UILabel()
    private let stackView = UIStackView()
    private let placeLabel = UILabel()
    private let weatherIconImageView = UIImageView()
    private let weatherText = UILabel()
    private let weatherStackView = UIStackView()
    
    func setup(with model: WeatherDetailsHeaderModel) {
        temperatureLabel.text = model.temperatureText
        temperatureLabel.textColor = model.temperatureState.color
        
        placeLabel.text = model.placeText
        weatherIconImageView.image = model.weatherIcon
        weatherText.text = model.weatherText
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(stackView)
    
        [temperatureLabel,
         placeLabel,
         weatherStackView].forEach(stackView.addArrangedSubview)
        
        [weatherText,
         weatherIconImageView].forEach(weatherStackView.addArrangedSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = Constants.temperatureLabelFont
        temperatureLabel.textColor = .black
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .leading
        
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.font = Constants.placeLabelFont
        placeLabel.textColor = .black
        
        weatherStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherStackView.alignment = .center
        weatherStackView.spacing = Constants.weatherStackViewSpacing
        
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImageView.contentMode = .scaleAspectFit
        
        weatherText.translatesAutoresizingMaskIntoConstraints = false
        weatherText.font = Constants.weatherTextLabelFont
        weatherText.textColor = .black
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.stackViewTop),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.stackViewBottom),
            
            weatherIconImageView.widthAnchor.constraint(equalToConstant: Constants.weatherIconImageViewSize),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: Constants.weatherIconImageViewSize),
        ])
    }
}
