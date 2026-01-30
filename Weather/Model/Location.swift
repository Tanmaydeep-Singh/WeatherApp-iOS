import Foundation

enum WeatherType: String, CaseIterable, Codable, Hashable {
    case sunny, foggy, rainy, windy, snow, clear, clouds
    
    var icon: String {
        switch self {
        case .sunny, .clear: return "sun.max.fill"
        case .foggy:         return "cloud.fog.fill"
        case .rainy:         return "cloud.rain.fill"
        case .windy:         return "wind"
        case .snow:          return "snow"
        case .clouds:        return "cloud.fill"
        }
    }
}

struct Location: Identifiable, Hashable, Equatable {
    let id: UUID
    let name: String
    let lat: Double
    let lon: Double
    
    var weather: WeatherType
    var description: String
    var iconURL: String?
    
    // Core Data Aligned Fields
    var currentTemp: Double?
    var feelsLike: Double?
    var humidity: Int?
    var pressure: Int?
    var visibility: Int?

    // Computed UI Helper
    var tempDisplay: String {
        if let current = currentTemp {
            return "\(Int(current.rounded()))°"
        }
        return "--°"
    }

    // Required for Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id &&
        lhs.lat == rhs.lat &&
        lhs.lon == rhs.lon &&
        lhs.name == rhs.name
    }

    init(
        id: UUID = UUID(),
        name: String,
        lat: Double,
        lon: Double,
        weather: WeatherType = .clear,
        currentTemp: Double? = nil,
        description: String = "",
        feelsLike: Double? = nil,
        humidity: Int? = nil,
        pressure: Int? = nil,
        visibility: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.lat = lat
        self.lon = lon
        self.weather = weather
        self.currentTemp = currentTemp
        self.description = description
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.pressure = pressure
        self.visibility = visibility
    }
}
