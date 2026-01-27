//
//  NetworkManager.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//

import SwiftUI

protocol NetworkProvider {
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T
}

final class NetworkManager: NetworkProvider {
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body

        let (data, response) = try await  URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
