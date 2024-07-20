//
//  Publisher+Extension.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Combine

extension Publisher {
    func convertToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}

public extension Publisher where Output: Collection {
    func mapMany<Result>(_ transform: @escaping (Output.Element) -> Result) -> Publishers.Map<Self, [Result]> {
        map { $0.map(transform) }
    }
}
