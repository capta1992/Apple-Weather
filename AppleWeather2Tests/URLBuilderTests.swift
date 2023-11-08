//
//  URLBuilderTests.swift
//  AppleWeather2Tests
//
//  Created by Lawson Falomo on 11/7/23.
//

import Foundation
@testable import AppleWeather2
import XCTest

class URLBuilderTests: XCTestCase {
    
    private var builder: URLComponentsBuilder!
    
    override func setUp() async throws {
        try? await super.setUp()
        builder = WeatherURLComponents()
    }
    
    override func tearDown() {
        builder = nil
        super.tearDown()
    }
    
    func testBuildingURL() async throws {
        let cityEndpoint: EndPoint = .city(cityName: "test")
        let locationEndpoint: EndPoint = .location(location: .init(lat: 0, lon: 0))
        
        let defaultQueryItems =  [
            URLQueryItem(name: "appid", value: "4d2e0d2683314a0b8d5208a5f0804e70"),
            URLQueryItem(name: "units", value: "imperial")
        ]
        
        let cityQueryItems = builder.queryItems(for: cityEndpoint)
        let locationQueryItems = builder.queryItems(for: locationEndpoint)
        
        XCTAssertEqual(builder.scheme, "https")
        XCTAssertEqual(builder.host, "api.openweathermap.org")
        XCTAssertEqual(builder.path, "/data/2.5/weather")
        
        let expectedCityQueryItems: [URLQueryItem] = defaultQueryItems + [URLQueryItem(name: "q", value: "test")]
        
        let expectedLocationQueryItems: [URLQueryItem] = defaultQueryItems + [
            URLQueryItem(name: "lat", value: "0.0"),
            URLQueryItem(name: "lon", value: "0.0")
        ]
        
        XCTAssertEqual(cityQueryItems, expectedCityQueryItems)
        XCTAssertEqual(locationQueryItems, expectedLocationQueryItems)
        
        let cityURL = try builder.build(for: cityEndpoint)
        let locationURL = try builder.build(for: locationEndpoint)
        
        let expectedCityURLString = "https://api.openweathermap.org/data/2.5/weather?appid=4d2e0d2683314a0b8d5208a5f0804e70&units=imperial&q=test"
        
        let expextedLocationURLString = "https://api.openweathermap.org/data/2.5/weather?appid=4d2e0d2683314a0b8d5208a5f0804e70&units=imperial&lat=0.0&lon=0.0"
        
        XCTAssertEqual(cityURL.absoluteString, expectedCityURLString)
        XCTAssertEqual(locationURL.absoluteString, expextedLocationURLString)
        
    }
}
