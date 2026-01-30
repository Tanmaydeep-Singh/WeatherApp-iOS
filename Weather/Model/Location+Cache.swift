import Foundation
import CoreData

extension Location {
    /// Initializes a Location struct from a Core Data entity
    init?(from cached: CachedWeather) {
        guard let name = cached.city else { return nil }
        
        self.id = UUID()
        self.name = name
        self.lat = cached.lat
        self.lon = cached.lon
        
        // Maps Core Data string back to our Enum
        self.weather = WeatherType(rawValue: (cached.condition ?? "").lowercased()) ?? .clear
        
        self.description = cached.weatherDescription ?? ""
        self.currentTemp = cached.temperature
        self.feelsLike = cached.feelsLike
        self.humidity = Int(cached.humidity)
        self.pressure = Int(cached.pressure)
        self.visibility = Int(cached.visibility)
        
        if let iconId = cached.iconId {
            self.iconURL = "https://openweathermap.org/img/wn/\(iconId)@4x.png"
        }
    }
}

extension CachedWeather {

    
}

extension Location {
    mutating func applyCache(_ cached: CachedWeather) {
        // Use the existing bridge initializer we built
        if let updated = Location(from: cached) {
            self.currentTemp = updated.currentTemp
            self.feelsLike = updated.feelsLike
            self.humidity = updated.humidity
            self.pressure = updated.pressure
            self.visibility = updated.visibility
            self.description = updated.description
            self.iconURL = updated.iconURL
            self.weather = updated.weather
        }
    }
}
