//
//  NetworkingServiceImp.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

class NetworkingServiceImp: NetworkingService {
    func fetch<T>(urlRequest: URLRequest) async throws -> T where T : Decodable {
        guard let url = urlRequest.url else { throw NetworkingError.couldNotmakeURL }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkingError.noHttpResponse
        }
        let model = try JSONDecoder().decode(T.self, from: data)
        return model
    }
}
