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

protocol SearchListCoordinatorProtocol: AnyObject {
    func showDetails()
}

final class AppCoordinator: AppCoordinatorProtocol {
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = SearchListViewModel()
        viewModel.coordinator = self
        
        let stationsListViewController = SearchListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: stationsListViewController)
        
        self.navigationController = navigationController
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: SearchListCoordinatorProtocol {
    func showDetails() {
        let detailsViewModel = WeatherDetailsViewModel()
        let detailsViewController = WeatherDetailsViewController(viewModel: detailsViewModel)
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
