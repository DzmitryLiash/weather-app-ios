//
//  SearchHistoryCache.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 25/07/2024.
//

import Foundation

final class SearchHistoryCache {
    private enum Constants {
        static let history = "searchHistory"
        static let historyItemsMaxCount = 5
    }
    
    private var defaults = UserDefaults.standard
    private var historyItems = [City]()
    
    init() {
        loadHistory()
    }
    
    func getSearchHistory() -> [City] {
        return historyItems
    }
    
    func addCityToHistoryCache(_ city: City) {
        if let index = historyItems.firstIndex(of: city) {
            historyItems.remove(at: index)
        }
        
        historyItems.insert(city, at: .zero)
        
        if historyItems.count > Constants.historyItemsMaxCount {
            historyItems.removeLast()
        }
        
        saveHistory()
    }
    
    func removeCityFromHistoryCache(_ city: City) {
        if let index = historyItems.firstIndex(of: city) {
            historyItems.remove(at: index)
            saveHistory()
        }
    }
    
    private func loadHistory() {
        DispatchQueue.global().async {
            guard let data = self.defaults.data(forKey: Constants.history) else { return }
            
            do {
                let searchHistoryCacheDto = try JSONDecoder().decode(SearchHistoryCacheDto.self, from: data)
                self.historyItems = searchHistoryCacheDto.searchHistoryCache.map(City.init)
            } catch {
                print("Failed to decode search history: \(error)")
            }
        }
    }
    
    private func saveHistory() {
        DispatchQueue.global().async {
            let searchHistoryCacheDto = SearchHistoryCacheDto(searchHistoryCache: self.historyItems.map(CityDto.init))
            
            do {
                let data = try JSONEncoder().encode(searchHistoryCacheDto)
                self.defaults.setValue(data, forKey: Constants.history)
            } catch {
                print("Failed to encode search history: \(error)")
            }
        }
    }
}


