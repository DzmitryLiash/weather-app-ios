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
                guard let response = output.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                guard (200...299).contains(response.statusCode) else {
                    if response.statusCode == 404 {
                        throw URLError(.fileDoesNotExist)
                    } else {
                        throw URLError(.badServerResponse)
                    }
                }
                
                return output.data
            }
            .decode(type: T.ResponseType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
