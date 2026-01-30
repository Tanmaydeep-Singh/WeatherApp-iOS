//
//  SwiftUIView.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//
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
    let pressure: Int
    let visibility: Int
    let iconId: String

    private enum CodingKeys: String, CodingKey {
        case name, main, weather, wind, visibility
    }

    private enum MainKeys: String, CodingKey {
        case temp, humidity, pressure
        case feelsLike = "feels_like"
    }

    private enum WeatherKeys: String, CodingKey {
        case main, description, icon
    }

    private enum WindKeys: String, CodingKey {
        case speed
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cityName = try container.decode(String.self, forKey: .name)
        visibility = try container.decode(Int.self, forKey: .visibility)

        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try mainContainer.decode(Double.self, forKey: .temp)
        feelsLike = try mainContainer.decode(Double.self, forKey: .feelsLike)
        humidity = try mainContainer.decode(Int.self, forKey: .humidity)
        pressure = try mainContainer.decode(Int.self, forKey: .pressure)

        var weatherArrayContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        let firstWeatherContainer = try weatherArrayContainer.nestedContainer(keyedBy: WeatherKeys.self)
        condition = try firstWeatherContainer.decode(String.self, forKey: .main)
        description = try firstWeatherContainer.decode(String.self, forKey: .description)
        iconId = try firstWeatherContainer.decode(String.self, forKey: .icon)

        let windContainer = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = try windContainer.decode(Double.self, forKey: .speed)
    }
}
