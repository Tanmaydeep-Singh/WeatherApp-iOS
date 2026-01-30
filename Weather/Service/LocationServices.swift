//
//  LocationServices.swift
//  Weather
//
//  Created by tanmaydeep on 30/01/26.
//
import Foundation
import CoreData

struct LocationServices {
    
    func saveLocation(_ location: Location) {
        let context = CoreDataManager.shared.context
        
        let fetchRequest: NSFetchRequest<CachedWeather> = CachedWeather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "city == %@", location.name)
        
        do {
            let results = try context.fetch(fetchRequest)
            let entity = results.first ?? CachedWeather(context: context)
            
            entity.update(from: location)
            
            CoreDataManager.shared.save()
            print("Successfully saved \(location.name) to Core Data")
        } catch {
            print("Error saving location: \(error)")
        }
    }
    
    func fetchSavedLocations() -> [Location] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CachedWeather> = CachedWeather.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CachedWeather.updatedAt, ascending: false)]
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.compactMap { Location(from: $0) }
        } catch {
            print("Failed to fetch locations: \(error.localizedDescription)")
            return []
        }
    }
}
