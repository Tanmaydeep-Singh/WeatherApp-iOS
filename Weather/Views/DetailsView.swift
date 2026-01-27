//
//  DetailsView.swift
//  Weather
//
//  Created by tanmaydeep on 23/01/26.
//

import SwiftUI

struct DetailsView: View {
    @Binding var path: NavigationPath
    @State var location: Location
    @State private var isLoading = false

    var body: some View {
        ZStack {            
            VStack(spacing: 16) {
                Text(location.name)
                    .font(.largeTitle).bold()
                    .foregroundStyle(.white)

                if isLoading {
                    ProgressView().tint(.white)
                } else {
                    Image(systemName: location.weather.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.yellow)

                    Text(location.currentTemp != nil ? "\(Int(location.currentTemp!))°" : location.temperature.temperatureText)
                        .font(.system(size: 60, weight: .medium))
                        .foregroundStyle(.white)
                }

                Text("A warm breeze drifted through the streets as the afternoon sun hovered behind scattered clouds.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.9))
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back") { path.removeLast() }.foregroundStyle(.white)
            }
        }
        .navigationBarBackButtonHidden()
        .task {
            await fetchLiveWeather()
        }
    }

    func fetchLiveWeather() async {
        isLoading = true
        let manager = NetworkManager.shared
        let endpoint = WeatherEndpoint.currentWeather(lat: location.lat, lon: location.lon)
        
        do {
            let result: WeatherResponse = try await manager.request(endpoint: endpoint)
            
            await MainActor.run {
                self.location.currentTemp = result.temperature
                self.location.weather = WeatherType(rawValue: result.condition.lowercased()) ?? .clear
                self.isLoading = false
            }
        } catch {
            print("Failed to fetch: \(error)")
            isLoading = false
        }
    }
}
