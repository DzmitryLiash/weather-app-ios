//
//  SearchCityEmptyResultCell.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 21/07/2024.
//

import UIKit

final class SearchCityEmptyResultCell: UITableViewCell {
    
    private enum Constants {
        static let containerViewLeading: CGFloat = 20
        static let containerViewTrailing: CGFloat = -20
        static let containerViewBottom: CGFloat = -16
        static let titleLabelFont: UIFont = UIFont(name: AppFont.interMedium, size: 16) ?? .systemFont(ofSize: 16, weight: .medium)
        static let titleLabelText: String = "Sorry, we can't find a city matching your \nsearch query - please try another one."
        static let titleLabelNumberOfLines: Int = 0
    }
    
    private let containerView = UIView()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    private func setupSubviews() {
        selectionStyle = .none
        contentView.backgroundColor = .white
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Constants.titleLabelFont
        titleLabel.textColor = .black
        titleLabel.text = Constants.titleLabelText
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerViewLeading),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.containerViewTrailing),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.containerViewBottom),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(lessThanOrEqualTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        ])
    }
}
