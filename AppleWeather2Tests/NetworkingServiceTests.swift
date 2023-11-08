//
//  NetworkingServiceTests.swift
//  AppleWeather2Tests
//
//  Created by Lawson Falomo on 11/7/23.
//

import Foundation
@testable import AppleWeather2
import XCTest

class NetworkingServiceTests: XCTestCase {
    
    private var networkingService: MockNetworkingService!
    
    override func setUp() async throws {
        try await super.setUp()
        // Create a default mock response, it could be a success or failure depending on what you want as default
        let defaultMockResponse = MockNetworkingService.Response.failure(NetworkingError.noData)
        networkingService = MockNetworkingService(mockReponse: defaultMockResponse)
    }
    
    func testFailureNetworkRequest() async {
        // Set the mock response to a failure for this test case
        networkingService.mockResponse = .failure(NetworkingError.noData)
        let url: URL = .init(string: "http://tinder.com")!

        do {
            let _ = try await networkingService.fetch(urlRequest: URLRequest(url: url)) as WireCityWeather
            XCTFail("Should Fail")
        } catch NetworkingError.noData {
            // Success: Correct error was thrown
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testSuccessNetworkRequest() async {
        // Create a WireCityWeather instance with the desired data
        let mockWeatherData = WireCityWeather(
            name: "Test City",
            main: .init(temp: 20.0, feels_like: 21.0, humidity: 50),
            weather: [.init(id: 800, description: "clear sky")]
        )
        // Set the mock response to a success for this test case
        networkingService.mockResponse = .success(mockWeatherData)

        let url: URL = .init(string: "https://fakeurl.com")!

        do {
            let cityWeather = try await networkingService.fetch(urlRequest: URLRequest(url: url)) as WireCityWeather
            // TODO: [OF] Perform your assertions here, e.g., XCTAssertNotNil(cityWeather)
        } catch {
            XCTFail("Should not hit failure result: \(error)")
        }
    }

}
