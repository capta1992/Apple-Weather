//
//  URLComponentsBuilder.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

// The Builder Object
protocol URLComponentsBuilder {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    
    func queryItems(for endpoint: EndPoint) -> [URLQueryItem]
    func build(for endpoint: EndPoint) throws -> URL
}

struct WeatherURLComponents: URLComponentsBuilder {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.openweathermap.org"
    }
    
    var path: String {
        "/data/2.5/weather"
    }
    
    func queryItems(for endpoint: EndPoint) -> [URLQueryItem] {
        switch endpoint {
        case .city(let cityName):
            return constantQueryItems + [URLQueryItem(name: "q", value: cityName)]
        case .location(let location):
            let locationQueryItems: [URLQueryItem] = [
                URLQueryItem(name: "lat", value: "\(location.lat)"),
                URLQueryItem(name: "lon", value: "\(location.lon)")
            ]
            return constantQueryItems + locationQueryItems
        }
    }
    
    private var constantQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "appid", value: "4d2e0d2683314a0b8d5208a5f0804e70"),
            URLQueryItem(name: "units", value: "imperial")
        ]
    }
    
    func build(for endpoint: EndPoint) throws -> URL {
        guard let url = components(for: endpoint).url else { throw NetworkingError.couldNotmakeURL }
        return url
    }
    
    private func components(for endpoint: EndPoint) -> URLComponents {
        var components: URLComponents = .init()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems(for: endpoint)
        return components
    }
}
