//
//  APIEndpoint.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//
import Foundation

enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension APIEndpoint {
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
}
