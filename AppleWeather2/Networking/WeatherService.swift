//
//  WeatherService.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/6/23.
//

import Foundation

protocol WeatherService {
    func weather(for city: String) async throws -> CityWeather
    func weather(for location: Location) async throws -> CityWeather
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
    
    func weather(for city: String) async throws -> CityWeather {
        guard let request = factory.makeRequest(for: .city(cityName: city)) else {
            throw NetworkingError.couldNotmakeURL
        }
        let wireModel: WireCityWeather = try await networkingService.fetch(urlRequest: request)
        return CityWeather(from: wireModel)
    }
    
    func weather(for location: Location) async throws -> CityWeather {
        guard let request = factory.makeRequest(for: .location(location: location)) else {
            throw NetworkingError.couldNotmakeURL
        }
        let wireModel: WireCityWeather = try await networkingService.fetch(urlRequest: request)
        return CityWeather(from: wireModel)
    }
}
