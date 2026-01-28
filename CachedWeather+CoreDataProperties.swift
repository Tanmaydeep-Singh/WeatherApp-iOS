//
//  CachedWeather+CoreDataProperties.swift
//  Weather
//
//  Created by tanmaydeep on 28/01/26.
//
//

public import Foundation
public import CoreData


public typealias CachedWeatherCoreDataPropertiesSet = NSSet

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

}

extension CachedWeather : Identifiable {

}
