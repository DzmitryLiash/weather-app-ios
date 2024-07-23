//
//  WeatherDetailsInfoCell.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 23/07/2024.
//

import UIKit

final class WeatherDetailsInfoCell: UITableViewCell {
    
    private enum Constants {
        static let measureNameLabelFont: UIFont = UIFont(name: AppFont.interBold, size: 16) ?? .boldSystemFont(ofSize: 16)
        static let measureLabelFont: UIFont = UIFont(name: AppFont.interMedium, size: 14) ?? .systemFont(ofSize: 14, weight: .medium)
        static let containerViewLeading: CGFloat = 20
        static let containerViewTrailing: CGFloat = -20
        static let containerViewBottom: CGFloat = -8
        static let measureLabelLeading: CGFloat = 8
        static let measureLabelTrailing: CGFloat = -8
        static let bottomBorderViewHeight: CGFloat = 1
    }
    
    private let containerView = UIView()
    private let measureNameLabel = UILabel()
    private let measureLabel = UILabel()
    private let bottomBorderView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: WeatherDetailsInfoModel) {
        measureNameLabel.text = model.measureName
        measureLabel.text = model.measure
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        
        [measureNameLabel,
         measureLabel,
         bottomBorderView].forEach(containerView.addSubview)
    }
    
    private func setupSubviews() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor(resource: .moderateBlue)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.backgroundColor = .white
        
        measureNameLabel.translatesAutoresizingMaskIntoConstraints = false
        measureNameLabel.font = Constants.measureNameLabelFont
        measureNameLabel.textColor = .white
        
        measureLabel.translatesAutoresizingMaskIntoConstraints = false
        measureLabel.font = Constants.measureLabelFont
        measureLabel.textAlignment = .right
        measureLabel.textColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerViewLeading),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.containerViewTrailing),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.containerViewBottom),
            
            measureNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            measureNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            measureLabel.leadingAnchor.constraint(lessThanOrEqualTo: measureNameLabel.trailingAnchor, constant: Constants.measureLabelLeading),
            measureLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.measureLabelTrailing),
            measureLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            bottomBorderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomBorderView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: Constants.bottomBorderViewHeight)
        ])
    }
}

