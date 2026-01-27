//
//  NetworkError.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case serverError(String)
    case unknown
}
