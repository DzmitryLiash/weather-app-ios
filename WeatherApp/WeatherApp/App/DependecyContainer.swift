//
//  DependecyContainer.swift
//  WeatherApp
//
//  Created by Dzmitry Liashchou on 20/07/2024.
//

import Foundation

@propertyWrapper public struct Injected<T> {
    public var wrappedValue: T

    public init(_ d: DependencyContainer = DependencyContainer.shared) {
        wrappedValue = d.resolve()
    }
}

public class DependencyContainer {
    public static let shared: DependencyContainer = .init()

    private var registrations = [String: () -> Any]()

    private init() { }

    public func register<T>(_ type: T.Type, _ factory: @escaping () -> T) {
        registrations[key(for: type)] = factory
    }

    public func resolve<T>() -> T {
        guard let resolved = registrations[key(for: T.self)]?() as? T else {
            fatalError("Dependency resolution error for type \(T.self) from \(registrations.keys.joined(separator: ", "))")
        }
        return resolved
    }

    private func key(for type: Any.Type) -> String {
        .init(describing: type)
    }
}
