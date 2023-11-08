//
//  NetworkingService.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

protocol NetworkingService {
    func fetch<T: Decodable>(urlRequest: URLRequest) async throws -> T
}
