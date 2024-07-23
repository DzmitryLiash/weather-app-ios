//
//  APIClient.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation
import Combine

protocol APIClient {
    func fetch<T: Endpoint>(endpoint: T) -> AnyPublisher<T.ResponseType, Error>
}

extension APIClient {
    func fetch<T: Endpoint>(endpoint: T) -> AnyPublisher<T.ResponseType, Error> {
        var urlComponents = URLComponents(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )
        
        if endpoint.method == .get, !endpoint.parameters.isEmpty {
            urlComponents?.queryItems = endpoint.parameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }
        
        guard let url = urlComponents?.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if endpoint.method != .get, !endpoint.parameters.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: endpoint.parameters)
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { output in
                if let response = output.response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: output.data)
                        if let apiError = errorResponse.error {
                            throw AppError.apiError(apiError)
                        } else {
                            throw AppError.unknown("Unknown error occurred.")
                        }
                    } catch {
                        throw AppError.unknown("Failed to decode error response")
                    }
                }
                return output.data
            }
            .decode(type: T.ResponseType.self, decoder: JSONDecoder())
            .mapError { error in
                return self.mapErrorToAppError(error)
            }
            .eraseToAnyPublisher()
    }
    
    private func mapErrorToAppError(_ error: Error) -> AppError {
        if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
            return .noInternetConnection
        } else if let appError = error as? AppError {
            return appError
        } else {
            return .unknown(error.localizedDescription)
        }
    }
}
