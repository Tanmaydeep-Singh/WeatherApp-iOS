//
//  CoreDataManager.swift
//  Weather
//
//  Created by tanmaydeep on 28/01/26.
//
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {}

    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
