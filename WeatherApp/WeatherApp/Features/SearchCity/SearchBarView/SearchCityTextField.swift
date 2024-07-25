//
//  SearchCityTextField.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import UIKit

class SearchCityTextField: UITextField {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let textInputFont: UIFont = UIFont(name: AppFont.interRegular, size: 16) ?? .systemFont(ofSize: 16)
        static let placeholderString: String = "Search the city"
        static let placeholderForegroundColor: UIColor = .black.withAlphaComponent(0.8)
        static let placeholderFont: UIFont = textInputFont
        static let borderLayerLineWidth: CGFloat = 1
        static let paddingViewSize: CGFloat = 48
        static let searchIconSize: CGFloat = 20
    }
    
    private let paddingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .search).withTintColor(.black))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupLeftView()
        setupKeyboard()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        font = Constants.textInputFont
        textColor = .black
        tintColor = .black
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderLayerLineWidth
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        attributedPlaceholder = NSAttributedString(
            string: Constants.placeholderString,
            attributes: [
                .foregroundColor: Constants.placeholderForegroundColor,
                .font: Constants.placeholderFont
            ]
        )
        backgroundColor = .white
    }
    
    private func setupLeftView() {
        paddingView.addSubview(searchIcon)
        leftView = paddingView
        leftViewMode = .always
    }
    
    private func setupKeyboard() {
        autocorrectionType = .no
        keyboardType = .alphabet
        returnKeyType = .search
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            paddingView.heightAnchor.constraint(equalToConstant: Constants.paddingViewSize),
            paddingView.widthAnchor.constraint(equalToConstant: Constants.paddingViewSize),
            
            searchIcon.heightAnchor.constraint(equalToConstant: Constants.searchIconSize),
            searchIcon.widthAnchor.constraint(equalToConstant: Constants.searchIconSize),
            searchIcon.centerXAnchor.constraint(equalTo: paddingView.centerXAnchor),
            searchIcon.centerYAnchor.constraint(equalTo: paddingView.centerYAnchor),
        ])
    }
}
