//
//  MockNetworkingService.swift
//  AppleWeather2Tests
//
//  Created by Lawson Falomo on 11/6/23.
//

import Foundation
@testable import AppleWeather2

class MockNetworkingService: NetworkingService {
    
    enum Response {
        case success(WireCityWeather)
        case failure(NetworkingError)
    }
    
    var mockResponse: Response
    
    init(mockReponse: Response) {
        self.mockResponse = mockReponse
    }
    
    func fetch<T>(urlRequest: URLRequest) async throws -> T where T : Decodable {
        switch mockResponse {
        case .success(let wireCityWeather):
            // Cast the mock data to the expected return type and retuen it
            guard let result = wireCityWeather as? T else {
                throw NetworkingError.decodingFailed
            }
            return result
        case .failure(let networkingError):
            throw networkingError
        }
    }
}
