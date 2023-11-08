//
//  NetworkingError.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

enum NetworkingError: Error, Equatable {
    case couldNotmakeURL
    case noData
    case noHttpResponse
    case networkingFailure(Error)
    case serialize(Error)
    case decodingFailed
    case mappingModels(Error)
    
    var debugMessage: String {
        switch self {
        case .couldNotmakeURL:
            return "DEBUG: Could not make the url provided"
        case .noData:
            return "DEBUG: could not find date from API reqquest"
        case .noHttpResponse:
            return "DEBUG: No Http response from API request"
        case .networkingFailure(let error):
            return "DEBUG: Networking Failure \(error.localizedDescription)"
        case .serialize(let error):
            return "DEBUG: Serialization Error \(error.localizedDescription)"
        case .decodingFailed:
            return "DEBUG: Decoding Failed"
        case .mappingModels(let error):
            return "DEBUG: Could not map wire model to data model \(error.localizedDescription)"
        }
    }
    static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        lhs.debugMessage == rhs.debugMessage
    }
}
