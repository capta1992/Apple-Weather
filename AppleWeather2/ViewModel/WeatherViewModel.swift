//
//  WeatherViewModel.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/6/23.
//

import Foundation

class WeatherViewModel {
    private let model: CityWeather
    
    init(model: CityWeather) {
        self.model = model
    }
    
    var cityName: String {
        model.name
    }
    
    var description: String {
        model.description
    }
    
    var feelsLike: String {
        return String(format: "%.0f", model.feelsLike)
    }
    
    var humidity: String {
        return "\(model.humidity)"
    }
    
    var temperatureString: String {
        return String(format: "%.0f", model.temperature)
    }
    
    var conditionImageName: String {
        switch model.id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
