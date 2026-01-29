//
//  WeatherApp.swift
//  Weather
//
//  Created by tanmaydeep on 23/01/26.
//

import SwiftUI

@main
struct WeatherApp: App {
    init() {
           #if DEBUG
           Thread.sleep(forTimeInterval: 1.5)
           #endif
       }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
