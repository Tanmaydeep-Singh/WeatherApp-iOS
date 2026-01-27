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
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text(location.name)
                            .font(.system(size: 34, weight: .bold))
                        
                        if let urlString = location.iconURL, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 120, height: 120)
                        }

                        Text(location.currentTemp != nil ? "\(Int(location.currentTemp!))°" : "--°")
                            .font(.system(size: 80, weight: .thin))
                        
                        Text(location.description.capitalized)
                            .font(.title3)
                            .secondaryText()
                    }
                    .padding(.top, 40)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        InfoCard(title: "FEELS LIKE", value: "\(Int(location.feelsLike ?? 0))°", icon: "thermometer.medium")
                        InfoCard(title: "HUMIDITY", value: "\(location.humidity ?? 0)%", icon: "humidity")
                        InfoCard(title: "VISIBILITY", value: "\( (location.visibility ?? 0) / 1000) km", icon: "eye")
                        InfoCard(title: "PRESSURE", value: "\(location.pressure ?? 0) hPa", icon: "gauge.with.dots")
                    }
                    .padding()
                }
            }
        }
        .foregroundStyle(.white)
        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    path.append(Route.settings)
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .task { await fetchLiveWeather() }
        
    }

    func fetchLiveWeather() async {
        isLoading = true
        let endpoint = WeatherEndpoint.currentWeather(lat: location.lat, lon: location.lon)
        
        do {
            let result: WeatherResponse = try await NetworkManager.shared.request(endpoint: endpoint)
            await MainActor.run {
                self.location.currentTemp = result.temperature
                self.location.feelsLike = result.feelsLike
                self.location.humidity = result.humidity
                self.location.pressure = result.pressure
                self.location.visibility = result.visibility
                self.location.description = result.description
                self.location.iconURL = "https://openweathermap.org/img/wn/\(result.iconId)@4x.png"
                self.isLoading = false
            }
        } catch {
            print("Error: \(error)")
            isLoading = false
        }
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                Text(title).font(.caption).bold()
            }
            .foregroundStyle(.white.opacity(0.6))
            
            Text(value)
                .font(.title2).bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white.opacity(0.1))
        .cornerRadius(15)
    }
}

extension View {
    func secondaryText() -> some View {
        self.foregroundStyle(.white.opacity(0.7))
    }
}
