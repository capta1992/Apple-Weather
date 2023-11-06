//
//  MockNetworkingService.swift
//  AppleWeather2Tests
//
//  Created by Lawson Falomo on 11/6/23.
//

import Foundation
@testable import AppleWeather2
import XCTest

class MockNetworkingService: NetworkingService {
    
    enum Response {
        case success
        case fail
    }
    
    var mockResponse: Response = .success
    
    func fetch<T>(urlRequest: URLRequest, completion: @escaping AppleWeather2.DataResult<T>) async throws where T : Decodable {
        switch mockResponse {
        case .success:
            if let bundlePath = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json"),
               let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8),
               let wireModel = try? JSONDecoder().decode(T.self, from: jsonData) {
                completion(.success(wireModel))
            } else {
                XCTFail("Failed to decode JSON from bundle")
            }
        case .fail:
            completion(.failure(.noData))
        }
    }
}
