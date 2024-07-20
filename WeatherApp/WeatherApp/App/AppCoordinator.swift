//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 19/07/2024.
//

import UIKit

protocol AppCoordinatorProtocol {
    func start()
}

protocol SearchCityCoordinatorProtocol: AnyObject {
    func showDetails()
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = SearchCityViewModel()
        viewModel.coordinator = self
        
        let searchCityViewController = SearchCityViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: searchCityViewController)
        self.navigationController = navigationController
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: SearchCityCoordinatorProtocol {
    func showDetails() {
        let detailsViewModel = WeatherDetailsViewModel()
        let detailsViewController = WeatherDetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
