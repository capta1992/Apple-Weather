//
//  URLRequestFactory.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

protocol URLRequestFactory {
    func makeRequest(for endpoint: EndPoint) -> URLRequest?
}

struct WeatherURLRequestFactory: URLRequestFactory {
    private let builder: URLComponentsBuilder
    
    init(builder: URLComponentsBuilder) {
        self.builder = builder
    }
    
    func makeRequest(for endpoint: EndPoint) -> URLRequest? {
        do {
            let url: URL = try builder.build(for: endpoint)
            return URLRequest(url: url)
        } catch let error as NetworkingError {
            print("DEBUG: \(error.debugMessage)")
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
