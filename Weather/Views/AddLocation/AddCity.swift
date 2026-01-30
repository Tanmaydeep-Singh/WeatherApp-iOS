//
//  AddCity.swift
//  Weather
//
//  Created by tanmaydeep on 30/01/26.
//

import SwiftUI

struct AddCity: View {
    @StateObject private var viewModel = AddLocationViewModel()

    var body: some View {
        List {
            if viewModel.searchText.isEmpty {
                Text("Search for a city (Try 'Mumbai' or 'Tokyo')")
                    .foregroundStyle(.secondary)
                    .listRowSeparator(.hidden)
            } else if viewModel.filteredLocations.isEmpty {
                Text("No results found")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.filteredLocations) { location in
                    LocationListItemView(
                        location: location,
                        onAdd: {
                            viewModel.addLocation(location)
                        }
                    )
                }
            }
        }
        .listStyle(.plain)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search any location"
        )
        .navigationTitle("Add City")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Location Added", isPresented: $viewModel.showSuccessAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("This city has been saved to your list.")
                }
    }
}
#Preview {
    AddCity()
}
