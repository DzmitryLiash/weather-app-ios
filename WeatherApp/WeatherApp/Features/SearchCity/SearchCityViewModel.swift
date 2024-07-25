//
//  SearchListViewModel.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation
import Combine

protocol SearchCityViewModelDelegate: AnyObject {
    func didUpdateState()
    func didOccurError(with error: AppError)
}

enum SearchCityViewState {
    case empty
    case searchHistory
    case searchResults
    case noResults
    
    var title: String {
        switch self {
        case .empty:
            return "Enter the name of the city"
        case .searchHistory:
            return "Search history"
        case .searchResults:
            return "Search results"
        case .noResults:
            return "No results"
        }
    }
}

final class SearchCityViewModel {
    
    @Injected var weatherAPI: WeatherAPI
    @Injected var searchHistoryCache: SearchHistoryCache
    
    weak var coordinator: SearchCityCoordinatorProtocol?
    weak var delegate: SearchCityViewModelDelegate?
    
    private(set) var state: SearchCityViewState = .empty {
        didSet {
            delegate?.didUpdateState()
        }
    }
    
    var items: [City] {
        switch state {
        case .empty:
            return []
        case .searchHistory:
            return searchHistory
        case .searchResults:
            return cities
        case .noResults:
            return [emptyResult]
        }
    }
    
    private var cities = [City]()
    private var emptyResult = City.emptyResult
    private var searchHistory = [City]()
    
    private var cancellables = Set<AnyCancellable>()
    
    func onViewDidLoad() {
        searchHistory = searchHistoryCache.getSearchHistory()
        
        state = searchHistory.isEmpty ? .empty : .searchHistory
    }
    
    func perfomSearch(with query: String) {
        fetchCities(with: query)
    }
    
    func showWeatherDetails(with city: City) {
        searchHistoryCache.addCityToHistoryCache(city)
        searchHistory = searchHistoryCache.getSearchHistory()
        
        coordinator?.showWeatherDetails(with: city)
    }
    
    func removeCityFromHistory(_ city: City) {
        searchHistoryCache.removeCityFromHistoryCache(city)
        searchHistory = searchHistoryCache.getSearchHistory()
        state = searchHistory.isEmpty ? .empty : .searchHistory
    }
    
    private func fetchCities(with query: String) {        
        guard !query.isEmpty else {
            state = searchHistory.isEmpty ? .empty : .searchHistory
            return
        }
        
        weatherAPI.fetchCities(with: query)
            .receive(on: RunLoop.main)
            .handleEvents(
                receiveOutput: { [weak self] cities in
                    self?.cities = cities
                    self?.state = cities.isEmpty ? .noResults : .searchResults
                }
            )
            .convertToResult()
            .sink { [weak self] result in
                if case let .failure(error) = result {
                    self?.delegate?.didOccurError(with: error)
                }
            }
            .store(in: &cancellables)
    }
}
