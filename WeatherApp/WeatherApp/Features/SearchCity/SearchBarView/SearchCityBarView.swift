//
//  SearchCityBarView.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 21/07/2024.
//

import UIKit

protocol SearchCityBarViewDelegate: AnyObject {
    func perfomSearch(with query: String)
}

final class SearchCityBarView: BaseView {
    
    weak var delegate: SearchCityBarViewDelegate?
    
    private enum Constants {
        static let stackViewSpacing: CGFloat = 16
        static let borderViewBackgroundColor: UIColor = .white.withAlphaComponent(0.6)
        static let searchTitleLabelFont: UIFont = UIFont(name: AppFont.interBold, size: 16) ?? .boldSystemFont(ofSize: 16)
        static let borderViewHeight: CGFloat = 0.5
        static let searchTextFieldViewLeading: CGFloat = 20
        static let searchTextFieldViewTrailing: CGFloat = -20
        static let searchTextFieldViewHeight: CGFloat = 48
        static let searchTitleLabelLeading: CGFloat = 20
        static let searchTitleLabelTrailing: CGFloat = -20
    }
    
    private let searchCityTextField = SearchCityTextField()
    private let searchTitleLabel = UILabel()
    private let borderView = UIView()
    private let stackView = UIStackView()
    
    func setup(with title: String) {
        searchTitleLabel.text = title
        searchTitleLabel.isHidden = title.isEmpty
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(stackView)
        
        [searchCityTextField,
         searchTitleLabel,
         borderView].forEach(stackView.addArrangedSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .firstBaseline
        stackView.spacing = Constants.stackViewSpacing
        
        searchCityTextField.translatesAutoresizingMaskIntoConstraints = false
        searchCityTextField.delegate = self
        
        searchTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchTitleLabel.font = Constants.searchTitleLabelFont
        searchTitleLabel.textAlignment = .left
        searchTitleLabel.textColor = .white
        searchTitleLabel.isHidden = true
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = Constants.borderViewBackgroundColor
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            searchCityTextField.leadingAnchor.constraint(
                equalTo: stackView.leadingAnchor,
                constant: Constants.searchTextFieldViewLeading
            ),
            searchCityTextField.trailingAnchor.constraint(
                equalTo: stackView.trailingAnchor,
                constant: Constants.searchTextFieldViewTrailing
            ),
            searchCityTextField.heightAnchor.constraint(equalToConstant: Constants.searchTextFieldViewHeight),
            
            searchTitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.searchTitleLabelLeading),
            searchTitleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Constants.searchTitleLabelTrailing),
            
            borderView.heightAnchor.constraint(equalToConstant: Constants.borderViewHeight),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension SearchCityBarView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let currentText = textField.text,
              let textRange = Range(range, in: currentText) else {
            return true
        }
        
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        
        if updatedText.contains("  ") {
            return false
        }
        
        return SearchCityTextFieldValidator.isValidInput(updatedText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let query = textField.text ?? ""
        delegate?.perfomSearch(with: query)
        
        return true
    }
}
