//
//  Location+Cache.swift
//  Weather
//
//  Created by tanmaydeep on 28/01/26.
//

import Foundation

extension Location {

    mutating func applyCache(_ cached: CachedWeather) {

        currentTemp = cached.temperature
        feelsLike = cached.feelsLike
        humidity = Int(cached.humidity)
        pressure = Int(cached.pressure)
        visibility = Int(cached.visibility)

        description = cached.weatherDescription ?? ""

        weather = WeatherType(
            rawValue: (cached.condition ?? "").lowercased()
        ) ?? .clear

        if let iconId = cached.iconId {
            iconURL = "https://openweathermap.org/img/wn/\(iconId)@4x.png"
        } else {
            iconURL = nil
        }
    }
}
