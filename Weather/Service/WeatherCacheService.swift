//
//  WeatherCacheService.swift
//  Weather
//
//  Created by tanmaydeep on 28/01/26.
//
import CoreData

struct WeatherCacheService {

    static func save(
        location: Location,
        response: WeatherResponse
    ) {
        let context = CoreDataManager.shared.context

        let request: NSFetchRequest<CachedWeather> = CachedWeather.fetchRequest()
        request.predicate = NSPredicate(
            format: "lat == %lf AND lon == %lf",
            location.lat,
            location.lon
        )

        let cached =
            (try? context.fetch(request).first)
            ?? CachedWeather(context: context)

        cached.city = location.name
        cached.lat = location.lat
        cached.lon = location.lon
        cached.temperature = response.temperature
        cached.feelsLike = response.feelsLike
        cached.humidity = Int64(response.humidity)
        cached.pressure = Int64(response.pressure)
        cached.visibility = Int64(response.visibility)
        cached.condition = response.condition
        cached.weatherDescription = response.description
        cached.iconId = response.iconId
        cached.updatedAt = Date()

        CoreDataManager.shared.save()
    }
}
