import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @StateObject private var themeManager = ThemeManager()

    
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .list:
                        ListView(path: $path)
                    case .details(let location):
                        DetailsView(path: $path, location: location)
                    case .settings:
                        SettingsView()
                    case .addLocation:
                        AddCity()
                                       }
              
                }
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(ThemeManager())

}
  
