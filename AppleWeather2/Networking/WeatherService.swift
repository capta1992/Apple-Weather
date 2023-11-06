//
//  WeatherService.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/6/23.
//

import Foundation

protocol WeatherService {
    func weather(for city: String, completion: @escaping WeatherCompletion) async throws
    func weather(for location: Location, completion: @escaping WeatherCompletion) async throws
}

class WeatherServiceImp: WeatherService {
    private let builder: URLComponentsBuilder
    private let factory: URLRequestFactory
    private let networkingService: NetworkingService
    
    init(builder: URLComponentsBuilder, factory: URLRequestFactory, networkingService: NetworkingService) {
        self.builder = builder
        self.factory = factory
        self.networkingService = networkingService
    }
    func weather(for city: String, completion: @escaping WeatherCompletion) async throws {
        guard let request = factory.makeRequest(for: .city(cityName: city)) else {
            return completion(.failure(.couldNotmakeURL))
        }
        try await execute(request: request, completion: completion)
    }
    
    func weather(for location: Location, completion: @escaping WeatherCompletion) async throws {
        guard let request = factory.makeRequest(for: .location(location: location)) else {
            return completion(.failure(.couldNotmakeURL))
        }
        try await execute(request: request, completion: completion)
    }
    
    private func execute(request: URLRequest, completion: @escaping WeatherCompletion) async throws {
        try await networkingService.fetch(urlRequest: request) { (result: WireWeatherResult) in
            do {
                let wiremodel = try result.get()
                let weatherModel: CityWeather = .init(from: wiremodel)
                completion(.success(weatherModel))
            } catch let error as NetworkingError {
                completion(.failure(error))
            } catch {
                completion(.failure(NetworkingError.networkingFailure(error)))
            }
        }
    }
}
