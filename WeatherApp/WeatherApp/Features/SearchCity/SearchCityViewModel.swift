//
//  SearchListViewModel.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation
import Combine

protocol SearchCityViewModelDelegate: AnyObject {
    func didFetchCities()
    func didOccurError(with error: Error)
}

final class SearchCityViewModel {
    
    @Injected var weatherAPI: WeatherAPI
    
    weak var coordinator: SearchCityCoordinatorProtocol?
    weak var delegate: SearchCityViewModelDelegate?
    
    var cities = [City]()
    var emptyResult = City.emptyResult
    
    private var cancellables = Set<AnyCancellable>()
    
    func perfomSearch(with query: String) {
        fetchCities(with: query)
    }
    
    func showWeatherDetails(with city: City) {
        coordinator?.showWeatherDetails(with: city)
    }
    
    private func fetchCities(with query: String) {
        guard !query.isEmpty else {
            return
        }
        
        weatherAPI.fetchCities(with: query)
            .handleEvents(receiveOutput: { [weak self] cities in
                self?.cities = cities
            })
            .convertToResult()
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                switch result {
                case .success:
                    self?.delegate?.didFetchCities()
                case let .failure(error):                    
                    self?.delegate?.didOccurError(with: error)
                }
            }
            .store(in: &cancellables)
    }
}
