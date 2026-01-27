import SwiftUI

struct ListView: View {
    @Binding var path: NavigationPath
    @StateObject private var viewModel = ListViewModel()

    var body: some View {
        List(viewModel.filteredLocations) { location in
            Button {
                path.append(Route.details(location: location))
            } label: {
                HStack {
                    Text(location.name)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Spacer()

                    Image(systemName: location.weather.icon)
                        .foregroundStyle(.yellow)
                }
            }
        }
        .listStyle(.plain)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search any location"
        )
        .navigationTitle("Locations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    path.append(Route.settings)
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView(path: .constant(NavigationPath()))
    }
}
