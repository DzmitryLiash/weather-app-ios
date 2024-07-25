//
//  APIClient.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation
import Combine

protocol APIClient {
    func fetch<T: Endpoint>(endpoint: T) -> AnyPublisher<T.ResponseType, AppError>
}

extension APIClient {
    func fetch<T: Endpoint>(endpoint: T) -> AnyPublisher<T.ResponseType, AppError> {
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
            return Fail(error: AppError.apiError("Bad URL")).eraseToAnyPublisher()
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
                guard let response = output.response as? HTTPURLResponse else {
                    throw AppError.unknown("Invalid response from server")
                }
                
                guard (200...299).contains(response.statusCode) else {
                    if let apiErrorResponse = try? JSONDecoder().decode(APIErrorResponseDto.self, from: output.data) {
                        throw AppError(apiErrorResponse: apiErrorResponse)
                    } else {
                        throw AppError.unknown("Failed to decode error response")
                    }
                }
                
                return output.data
            }
            .decode(type: T.ResponseType.self, decoder: JSONDecoder())
            .mapError { error in
                mapErrorToAppError(error)
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
