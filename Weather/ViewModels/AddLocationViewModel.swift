//
//  AddLocationViewModel.swift
//  Weather
//
//  Created by tanmaydeep on 30/01/26.
//

import Foundation
import Combine

class AddLocationViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredLocations: [Location] = []
    
    @Published var showSuccessAlert = false
    
    private let service = LocationServices()
    private var cancellables = Set<AnyCancellable>()
    
    private let dummySource = [
        Location(name: "Mumbai", lat: 19.0760, lon: 72.8777, weather: .sunny, currentTemp: 32, description: "Sunny"),
        Location(name: "London", lat: 51.5074, lon: -0.1278, weather: .rainy, currentTemp: 12, description: "Light Rain"),
        Location(name: "New York", lat: 40.7128, lon: -74.0060, weather: .clouds, currentTemp: 5, description: "Overcast"),
        Location(name: "Tokyo", lat: 35.6762, lon: 139.6503, weather: .clear, currentTemp: 18, description: "Clear Sky"),
        Location(name: "Paris", lat: 48.8566, lon: 2.3522, weather: .foggy, currentTemp: 10, description: "Misty")
    ]
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text in
                if text.isEmpty {
                    self?.filteredLocations = []
                } else {
                    self?.filteredLocations = self?.dummySource.filter {
                        $0.name.lowercased().contains(text.lowercased())
                    } ?? []
                }
            }
            .store(in: &cancellables)
    }

    func addLocation(_ location: Location) {
        service.saveLocation(location)
        self.showSuccessAlert = true
    }
}
