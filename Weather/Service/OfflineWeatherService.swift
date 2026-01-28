//
//  OfflineWeatherService.swift
//  Weather
//
//  Created by tanmaydeep on 28/01/26.
//
import CoreData

struct OfflineWeatherService {

    static func fetch(
        lat: Double,
        lon: Double
    ) -> CachedWeather? {

        let request: NSFetchRequest<CachedWeather> = CachedWeather.fetchRequest()
        request.predicate = NSPredicate(
            format: "lat == %lf AND lon == %lf",
            lat, lon
        )

        return try? CoreDataManager.shared.context.fetch(request).first
    }
}
