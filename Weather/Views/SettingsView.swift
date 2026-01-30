//
//  SettingsView.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//
import SwiftUI
import CoreData

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showingDeleteAlert = false

    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle("Dark Mode", isOn: $themeManager.isDarkMode)
            }
            
            Section(header: Text("Data Management")) {
                Button(role: .destructive) {
                    showingDeleteAlert = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Clear All Saved Locations")
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Clear All Data?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete Everything", role: .destructive) {
                clearAllCoreData()
            }
        } message: {
            Text("This will remove all saved cities and cached weather information. This action cannot be undone.")
        }
    }

    // MARK: - Core Data Logic
    private func clearAllCoreData() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CachedWeather.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            CoreDataManager.shared.save()
            print("Successfully cleared all weather data.")
        } catch {
            print("Failed to clear data: \(error.localizedDescription)")
        }
    }
}

