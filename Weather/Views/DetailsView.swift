//
//  DetailsView.swift
//  Weather
//
//  Created by tanmaydeep on 23/01/26.
//
import SwiftUI

struct DetailsView: View {
    @Binding var path: NavigationPath
    let location: Location

    var body: some View {
        ZStack {

            VStack(spacing: 16) {
                Text(location.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                Image(systemName: location.weather.icon)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.yellow)

                Text(location.temperature.temperatureText)
                    .font(.title2)
                    .foregroundStyle(.gray)

                Text(
                    "A warm breeze drifted through the streets as the afternoon sun hovered behind scattered clouds. Weather shifts gently as the day moves forward."
                )
                .foregroundStyle(.white)
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        path.removeLast()
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("Details")
                        .foregroundStyle(.white)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Home") {
                        path = NavigationPath()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
