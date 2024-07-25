//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Combine
import Foundation

protocol WeatherDetailsViewModelDelegate: AnyObject {
    func didFetchWeatherDetails()
    func didOccurError(with error: AppError)
}

final class WeatherDetailsViewModel {
    
    weak var delegate: WeatherDetailsViewModelDelegate?
    
    @Injected var weatherAPI: WeatherAPI
    
    private var cancellables = Set<AnyCancellable>()
    
    private var weatherDetails: WeatherDetails?
    
    private let city: City
    
    init(city: City) {
        self.city = city
    }
    
    func onViewDidLoad() {
        fetchWeatherDetails()
    }
    
    func getWeatherHeaderModel() -> WeatherDetailsHeaderModel? {
        guard let weatherDetails else {
            return nil
        }
        
        let temperatureText = String(weatherDetails.temperature.metric.value) + "°C"
        let temperatureState = TemperatureState(temperature: weatherDetails.temperature.metric.value)
        let placeText = "\(city.country), \(city.localizedName)"
        let weatherText = weatherDetails.weatherText
        let weatherIcon = WeatherIconProvider.getIcon(for: weatherDetails.weatherIcon)
        
        return WeatherDetailsHeaderModel(
            temperatureText: temperatureText,
            temperatureState: temperatureState,
            placeText: placeText,
            weatherText: weatherText,
            weatherIcon: weatherIcon
        )
    }
    
    func getWeatherInfoModels() -> [WeatherDetailsInfoModel] {
        guard let weatherDetails else {
            return []
        }
        
        let uvIndexMeasure = "\(weatherDetails.uvIndex) \(weatherDetails.uvIndexText)"
        let uvIndexModel = createMeasureModel(name: "UV Index", value: uvIndexMeasure)
        
        let windMeasure = "\(weatherDetails.wind.direction.localized) \(formatMetricValue(value: weatherDetails.wind.speed.metric.value, unit: weatherDetails.wind.speed.metric.unit, phrase: weatherDetails.wind.speed.metric.phrase))"
        let windModel = createMeasureModel(name: "Wind", value: windMeasure)
        
        let pressureMeasure = formatMetricValue(value: weatherDetails.pressure.metric.value, unit: weatherDetails.pressure.metric.unit, phrase: weatherDetails.pressure.metric.phrase)
        let pressureModel = createMeasureModel(name: "Pressure", value: pressureMeasure)
        
        let cloudCoverModel = createMeasureModel(name: "Cloud cover", value: weatherDetails.cloudCover)
        
        let visibilityMeasure = formatMetricValue(value: weatherDetails.visibility.metric.value, unit: weatherDetails.visibility.metric.unit, phrase: weatherDetails.visibility.metric.phrase)
        let visibilityModel = createMeasureModel(name: "Visibility", value: visibilityMeasure)
        
        return [uvIndexModel, windModel, pressureModel, cloudCoverModel, visibilityModel]
    }
    
    private func fetchWeatherDetails() {
        weatherAPI.fetchCityWeather(with: city.key)
            .handleEvents(receiveOutput: { [weak self] weatherDetails in
                guard let weatherDetails = weatherDetails.first else {
                    return
                }
                self?.weatherDetails = weatherDetails
            })
            .convertToResult()
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                switch result {
                case .success:
                    self?.delegate?.didFetchWeatherDetails()
                case let .failure(error):
                    self?.handleError(error)
                }
            }
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: Error) {
        if let appError = error as? AppError {
            delegate?.didOccurError(with: appError)
        } else {
            delegate?.didOccurError(with: AppError.unknown(error.localizedDescription))
        }
    }
    
    private func createMeasureModel(name: String, value: String) -> WeatherDetailsInfoModel {
        WeatherDetailsInfoModel(measureName: name, measure: value)
    }
    
    private func formatMetricValue(value: Double, unit: String, phrase: String?) -> String {
        if let phrase {
            return "\(value) \(unit) \(phrase)"
        } else {
            return "\(value) \(unit)"
        }
    }
}
