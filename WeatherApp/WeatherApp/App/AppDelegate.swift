//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 19/07/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinatorProtocol?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        registerDependencies()
        
        let appCoordinator = AppCoordinator(window: window)
        self.coordinator = appCoordinator
        appCoordinator.start()
        
        return true
    }
}

private func registerDependencies() {
    DependencyContainer.shared.register(WeatherAPI.self, WeatherAPIService.init)
}
