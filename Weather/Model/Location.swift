import Foundation

struct Location: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let lat: Double
    let lon: Double
    var weather: WeatherType
    var temperature: TemperatureRange
    var currentTemp: Double? 
}

enum WeatherType: String {
    case sunny, foggy, rainy, windy, snow, clear, clouds
    
    var icon: String {
        switch self {
        case .sunny, .clear: return "sun.max.fill"
        case .foggy: return "cloud.fog.fill"
        case .rainy: return "cloud.rain.fill"
        case .windy: return "wind"
        case .snow: return "snow"
        case .clouds: return "cloud.fill"
        }
    }
}

struct TemperatureRange: Hashable {
    let min: Int
    let max: Int
    
    var temperatureText: String {
        "H:\(max)° L:\(min)°"
    }
}
