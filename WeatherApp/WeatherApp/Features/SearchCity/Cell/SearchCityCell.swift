//
//  SearchCityCell.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 21/07/2024.
//

import UIKit

final class SearchCityCell: UITableViewCell {
    
    private enum Constants {
        static let containerViewCornerRadius: CGFloat = 8
        static let containerViewBorderWidth: CGFloat = 1
        static let stackViewSpacing: CGFloat = 8
        static let subtitleLabelTextColor: UIColor = .white.withAlphaComponent(0.8)
        static let titleLabelFont: UIFont = UIFont(name: AppFont.interBold, size: 20) ?? .boldSystemFont(ofSize: 20)
        static let subtitleLabelFont: UIFont = UIFont(name: AppFont.interRegular, size: 12) ?? .systemFont(ofSize: 12)
        static let containerViewLeading: CGFloat = 20
        static let containerViewTrailing: CGFloat = -20 
        static let containerViewBottom: CGFloat = -16
        static let stackViewLeading: CGFloat = 16
        static let stackViewTrailing: CGFloat = -16
    }
    
    private let containerView = UIView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with city: City) {
        titleLabel.text = city.localizedName
        subtitleLabel.text = city.administrativeArea + ", " + city.country
    }
        
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        
        [titleLabel, subtitleLabel].forEach(stackView.addArrangedSubview)
    }
    
    private func setupSubviews() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor(resource: .moderateBlue)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius
        containerView.layer.borderWidth = Constants.containerViewBorderWidth
        containerView.layer.borderColor = UIColor.white.cgColor
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Constants.stackViewSpacing
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Constants.titleLabelFont
        titleLabel.textColor = .white
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = Constants.subtitleLabelFont
        subtitleLabel.textColor = Constants.subtitleLabelTextColor
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerViewLeading),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.containerViewTrailing),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.containerViewBottom),
            
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.stackViewLeading),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.stackViewTrailing),
            
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
}
