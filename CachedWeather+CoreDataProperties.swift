//
//  CachedWeather+CoreDataProperties.swift
//  Weather
//
//  Created by tanmaydeep on 28/01/26.
//
//
import Foundation
import CoreData

extension CachedWeather {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedWeather> {
        return NSFetchRequest<CachedWeather>(entityName: "CachedWeather")
    }

    @NSManaged public var city: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var temperature: Double
    @NSManaged public var humidity: Int64
    @NSManaged public var feelsLike: Double
    @NSManaged public var pressure: Int64
    @NSManaged public var visibility: Int64
    @NSManaged public var weatherDescription: String?
    @NSManaged public var condition: String?
    @NSManaged public var iconId: String?
    @NSManaged public var updatedAt: Date?
    
    func update(from location: Location) {
        self.city = location.name
        self.lat = location.lat
        self.lon = location.lon
        self.temperature = location.currentTemp ?? 0.0
        self.condition = location.weather.rawValue
        self.weatherDescription = location.description
        self.humidity = Int64(location.humidity ?? 0)
        self.feelsLike = location.feelsLike ?? 0.0
        
        if let url = location.iconURL {
            self.iconId = url.components(separatedBy: "/").last?.replacingOccurrences(of: "@4x.png", with: "")
        }
        
        self.updatedAt = Date()
    }
}
