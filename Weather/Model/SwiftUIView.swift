//
//  SwiftUIView.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//

import Foundation

struct WeatherResponse: Decodable {
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let condition: String
    let description: String
    let windSpeed: Double
    
    private enum CodingKeys: String, CodingKey {
        case name
        case main
        case weather
        case wind
    }
    
    private enum MainKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
    }
    
    private enum WeatherKeys: String, CodingKey {
        case main
        case description
    }
    
    private enum WindKeys: String, CodingKey {
        case speed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cityName = try container.decode(String.self, forKey: .name)
        
        let mainContainer = try container.nestedContainer(
            keyedBy: MainKeys.self,
            forKey: .main
        )
        temperature = try mainContainer.decode(Double.self, forKey: .temp)
        feelsLike = try mainContainer.decode(Double.self, forKey: .feelsLike)
        humidity = try mainContainer.decode(Int.self, forKey: .humidity)
        
        let weatherArray = try container.decode([WeatherInfo].self, forKey: .weather)
        condition = weatherArray.first?.main ?? "N/A"
        description = weatherArray.first?.description ?? "N/A"
        
        let windContainer = try container.nestedContainer(
            keyedBy: WindKeys.self,
            forKey: .wind
        )
        windSpeed = try windContainer.decode(Double.self, forKey: .speed)
    }
}

private struct WeatherInfo: Decodable {
    let main: String
    let description: String
}
