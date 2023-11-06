//
//  WeatherServiceDependencies.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/6/23.
//

import Foundation

enum WeatherServiceDependencies {
    private static let builder: URLComponentsBuilder = WeatherURLComponents()
    private static let factory: URLRequestFactory = WeatherURLRequestFactory(builder: builder)
    private static let networkingService: NetworkingServiceImp = NetworkingServiceImp()
    
    static let weatherservice: WeatherService = WeatherServiceImp(
        builder: builder,
        factory: factory,
        networkingService: networkingService
    )
}
