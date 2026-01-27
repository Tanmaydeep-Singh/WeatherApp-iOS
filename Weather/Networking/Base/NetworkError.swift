//
//  NetworkError.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingError:
            return "Failed to decode data"
        case .serverError(let message):
            return message
        }
    }
}
