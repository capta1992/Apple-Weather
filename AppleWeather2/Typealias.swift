//
//  Typealias.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/5/23.
//

import Foundation

typealias DataResult<T: Decodable> = (Result<T, NetworkingError>) -> Void
