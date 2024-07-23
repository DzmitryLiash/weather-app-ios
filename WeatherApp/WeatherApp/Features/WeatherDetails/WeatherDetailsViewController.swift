//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import UIKit

final class WeatherDetailsViewController: BaseViewController {
    
    private enum Constants {
        static let headerViewTop: CGFloat = 20
        static let headerViewLeading: CGFloat = 20
        static let headerViewTrailing: CGFloat = -20
    }
    
    private let headerView = WeatherDetailsHeaderView()
    private let infoView = WeatherDetailsInfoView()
    
    private let viewModel: WeatherDetailsViewModel
    
    init(viewModel: WeatherDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onViewDidLoad()
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        [headerView, infoView].forEach(view.addSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.headerViewTop),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.headerViewLeading),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.headerViewTrailing),
            
            infoView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupHeaderView() {
        guard let weatherHeaderModel = viewModel.getWeatherHeaderModel() else {
            headerView.isHidden = true
            return
        }
        
        headerView.setup(with: weatherHeaderModel)
    }
    
    private func setupInfoContainerView() {
        let weatherContainerModels = viewModel.getWeatherInfoModels()

        guard !weatherContainerModels.isEmpty else {
            infoView.isHidden = true
            return
        }
        
        infoView.setup(with: weatherContainerModels)
    }
}

extension WeatherDetailsViewController: WeatherDetailsViewModelDelegate {
    func didFetchWeatherDetails() {
        setupHeaderView()
        setupInfoContainerView()
    }
    
    func didOccurError(with error: AppError) {
        let errorInfo = error.errorInfo()
        showErrorAlert(title: errorInfo.title, message: errorInfo.description)
    }
}
