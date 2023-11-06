//
//  NetworkingServiceImp.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

class NetworkingServiceImp: NetworkingService {
    func fetch<T>(urlRequest: URLRequest, completion: @escaping DataResult<T>) async throws where T : Decodable {
        guard let url = urlRequest.url else { throw NetworkingError.couldNotmakeURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(NetworkingError.noHttpResponse))
            } else {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            }
        } catch {
            completion(.failure(NetworkingError.networkingFailure(error)))
        }
    }
}
