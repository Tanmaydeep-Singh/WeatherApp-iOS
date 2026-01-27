import Foundation
import Combine

class ListViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    @Published var locations: [Location] = [
        Location(name: "Mumbai", lat: 19.0760, lon: 72.8777, weather: .sunny, temperature: .init(min: 22, max: 32) , description: "empty"),
        Location(name: "New Delhi", lat: 28.6139, lon: 77.2090, weather: .foggy, temperature: .init(min: 11, max: 24), description: ""),
        Location(name: "Chennai", lat: 13.0827, lon: 80.2707, weather: .sunny, temperature: .init(min: 24, max: 36) , description: ""),
        Location(name: "Bengaluru", lat: 12.9716, lon: 77.5946, weather: .rainy, temperature: .init(min: 24, max: 30), description: ""),
        Location(name: "Hyderabad", lat: 17.3850, lon: 78.4867, weather: .windy, temperature: .init(min: 22, max: 32), description: "")
    ]

    var filteredLocations: [Location] {
        searchText.isEmpty ? locations : locations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
