//
//  ThemeManager.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//

import SwiftUI
import Combine

@MainActor
final class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
}
