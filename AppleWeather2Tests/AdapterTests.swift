//
//  AdapterTests.swift
//  AppleWeather2Tests
//
//  Created by Lawson Falomo on 11/6/23.
//

import Foundation
import CoreLocation
@testable import AppleWeather2
import XCTest

class AdapterTests: XCTestCase {
    func testMappingWireModelToDataModel() {
        let main: WireCityWeather.Main = .init(temp: 10, feels_like: 10, humidity: 5)
        let weather: WireCityWeather.Weather = .init(id: 1, description: "overcast clouds")
        let wireModel: WireCityWeather = .init(name: "test", main: main, weather: [weather])
        let dataModel: CityWeather = .init(from: wireModel)
        
        XCTAssertEqual(dataModel.humidity, main.humidity)
        XCTAssertEqual(dataModel.feelsLike, main.feels_like)
        XCTAssertEqual(dataModel.temperature, main.temp)
        XCTAssertEqual(dataModel.name, wireModel.name)
    }
    
    func testCLLocationCoordinate2d() {
        let coordinate = CLLocationCoordinate2D(latitude: 50, longitude: 50)
        let location = coordinate.location
        XCTAssertEqual(location.lat, 50)
        XCTAssertEqual(location.lon, 50)
    }
}
