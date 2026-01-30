//
//  routes.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//

enum Route: Hashable {
    case list
    case details(location: Location)
    case settings
    case addLocation
}
