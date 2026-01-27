import SwiftUI
import Combine

class ListViewModel: ObservableObject {
    @Published var searchText: String = ""

    let locations: [Location] = [
        Location(name: "Mumbai", weather: .sunny, temperature: .init(min: 22, max: 32)),
        Location(name: "New Delhi", weather: .foggy, temperature: .init(min: 11, max: 24)),
        Location(name: "Chennai", weather: .sunny, temperature: .init(min: 24, max: 36)),
        Location(name: "Pune", weather: .sunny, temperature: .init(min: 22, max: 32)),
        Location(name: "Bengaluru", weather: .rainy, temperature: .init(min: 24, max: 30)),
        Location(name: "Gurgaon", weather: .foggy, temperature: .init(min: 11, max: 23)),
        Location(name: "Noida", weather: .snow, temperature: .init(min: 9, max: 22)),
        Location(name: "Hyderabad", weather: .windy, temperature: .init(min: 22, max: 32)),
        Location(name: "Ahmedabad", weather: .sunny, temperature: .init(min: 20, max: 32)),
        Location(name: "Indore", weather: .sunny, temperature: .init(min: 18, max: 24))
    ]

    var filteredLocations: [Location] {
        searchText.isEmpty
        ? locations
        : locations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
