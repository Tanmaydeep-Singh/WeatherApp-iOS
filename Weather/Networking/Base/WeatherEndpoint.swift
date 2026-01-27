//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//

import Foundation

enum WeatherEndpoint: APIEndpoint {
    case currentWeather(lat: Double, lon: Double)
    
    var baseURL: URL { URL(string: "https://api.openweathermap.org")! }
    
    var path: String { "/data/2.5/weather" }
    
    var method: HTTPMethod { .get }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .currentWeather(let lat, let lon):
            return [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: ""), // Key from our secure config
                URLQueryItem(name: "units", value: "metric")
            ]
        }
    }
}
