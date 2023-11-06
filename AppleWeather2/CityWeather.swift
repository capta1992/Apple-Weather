//
//  CityWeather.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

struct CityWeather {
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let name: String
    let id: Int
    let description: String
    
    init(from wireModel: WireCityWeather) {
        self.temperature = wireModel.main.temp
        self.feelsLike = wireModel.main.feels_like
        self.humidity = wireModel.main.humidity
        self.name = wireModel.name
        self.id = wireModel.weather[0].id
        self.description = wireModel.weather[0].description
    }
}
