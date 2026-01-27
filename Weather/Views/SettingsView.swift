//
//  SettingsView.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(){
            Form {
            Toggle("Dark Mode", isOn: $themeManager.isDarkMode)
                          }
               }
        .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    SettingsView()
        .environmentObject(ThemeManager())

}
