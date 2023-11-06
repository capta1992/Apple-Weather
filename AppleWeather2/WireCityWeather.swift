//
//  WireCityWeather.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

struct WireCityWeather: Codable {
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let humidity: Int
    }
    
    struct Weather: Codable {
        let id: Int
        let description: String
    }
    
    let name: String
    let main: Main
    let weather: [Weather]
}
