//
//  WeatherApp.swift
//  Weather
//
//  Created by tanmaydeep on 23/01/26.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    @StateObject private var themeManager = ThemeManager()

    init() {
           #if DEBUG
           Thread.sleep(forTimeInterval: 1.5)
           #endif
       }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .preferredColorScheme( themeManager.isDarkMode ? .dark : .light )
        }
    }
}
