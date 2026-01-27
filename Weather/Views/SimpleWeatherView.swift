//
//  SimpleWeatherView.swift
//  Weather
//
//  Created by tanmaydeep on 27/01/26.
//
import SwiftUI

struct SimpleWeatherResponse: Codable {
    let name: String
    let main: MainWeather
    let weather: [WeatherCondition]
}

struct MainWeather: Codable {
    let temp: Double
}

struct WeatherCondition: Codable {
    let description: String
}

struct SimpleWeatherView: View {
    @State private var weatherData: SimpleWeatherResponse?
    @State private var errorMessage: String?
    
    // Replace with your actual key from OpenWeatherMap
    private let apiKey = "9533d6f76555ba44c994f2504314cdd3"
    
    var body: some View {
        VStack(spacing: 20) {
            if let weather = weatherData {
                VStack {
                    Text(weather.name)
                        .font(.title)
                        .foregroundColor(.secondary)
                    
                    Text("\(Int(weather.main.temp))°C")
                        .font(.system(size: 70, weight: .thin))
                    
                    Text(weather.weather.first?.description.capitalized ?? "")
                        .font(.headline)
                }
            } else if let error = errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                ProgressView("Loading Weather...")
            }
        }
        .padding()
        .task {
            await fetchWeatherData()
        }
    }
    
    func fetchWeatherData() async {
        // Delhi: lat=28.61, lon=77.20
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=28.61&lon=77.20&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(SimpleWeatherResponse.self, from: data)
            self.weatherData = decodedResponse
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    SimpleWeatherView()
}
