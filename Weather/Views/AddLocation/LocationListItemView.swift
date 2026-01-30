//
//  LocationListItemView.swift
//  Weather
//
//  Created by tanmaydeep on 30/01/26.
//

import SwiftUI
struct LocationListItemView: View {
    let location: Location
    let onAdd: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: location.weather.icon)
                .font(.title2)
                .symbolRenderingMode(.multicolor)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(location.name)
                    .font(.headline)

                Text(location.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
            
            Text(location.tempDisplay)
                .font(.title3)
                .fontWeight(.medium)

            Button(action: onAdd) {
                Image(systemName: "plus.circle.fill")
                    .font(.title3)
                    .foregroundStyle(.blue)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    LocationListItemView(
        location: Location(
            id: UUID(),
            name: "Delhi",
            lat: 28.6139,
            lon: 77.2090,
            weather: .clear,
            currentTemp: 26,
            description: "Clear Skies"
        ),
        onAdd: {
            print("Add button tapped in preview")
        }
    )
}
