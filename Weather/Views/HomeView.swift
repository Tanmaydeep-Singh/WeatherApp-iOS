import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            // 🔹 Center content
            VStack(spacing: 16) {
                Image("umbrella")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)

                Text("Breeze")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Text("Weather App")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .frame(maxHeight: .infinity)

            Button {
                path.append(Route.list)
            } label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 64, height: 64)
                    .background(Circle().fill(.blue))
            }
            .padding(.bottom, 32)
        }
        .padding()
    }
}

#Preview {
    HomeView(path: .constant(NavigationPath()))
}
