//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 19/07/2024.
//

import UIKit

class SearchCityViewController: BaseViewController {
    
    private enum Constants {
        static let searchTextFieldViewLeading: CGFloat = 20
        static let searchTextFieldViewTrailing: CGFloat = -20
        static let searchTextFieldViewHeight: CGFloat = 48
    }
    
    private let searchCityTextField = SearchCityTextField()
    
    private let viewModel: SearchCityViewModel
    
    init(viewModel: SearchCityViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(searchCityTextField)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        searchCityTextField.translatesAutoresizingMaskIntoConstraints = false
        searchCityTextField.delegate = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            searchCityTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchCityTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.searchTextFieldViewLeading
            ),
            searchCityTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.searchTextFieldViewTrailing
            ),
            searchCityTextField.heightAnchor.constraint(equalToConstant: Constants.searchTextFieldViewHeight),
        ])
    }
}

extension SearchCityViewController: UITextFieldDelegate {
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
        return SearchCityTextFieldValidator.isValidInput(updatedText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
