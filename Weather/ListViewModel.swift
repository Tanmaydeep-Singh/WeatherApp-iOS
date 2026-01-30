//
//  ListViewModel.swift
//  Weather
//
//  Created by tanmaydeep on 30/01/26.
//
import Foundation
import Combine
import CoreData

class ListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var locations: [Location] = []

    func loadLocations() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CachedWeather> = CachedWeather.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "city", ascending: true)]
        
        do {
            let results = try context.fetch(fetchRequest)
            self.locations = results.compactMap { Location(from: $0) }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }

    var filteredLocations: [Location] {
        searchText.isEmpty ? locations : locations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func addLocation(_ location: Location) {
        let context = CoreDataManager.shared.context
        
        let fetchRequest: NSFetchRequest<CachedWeather> = CachedWeather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "city == %@", location.name)
        
        let existingEntity = try? context.fetch(fetchRequest).first
        let entity = existingEntity ?? CachedWeather(context: context)
        
        entity.update(from: location)
        
        CoreDataManager.shared.save()
        
        loadLocations()
    }
}
