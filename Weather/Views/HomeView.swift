import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Spacer()

                Image("umbrella")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)

                Text("Breeze")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Text("Weather App")
                    .foregroundStyle(.gray)

                Spacer()

                Button {
                    path.append(Route.list)
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(.white)
                        .background(
                            Circle()
                                .fill(.blue)
                                .frame(width: 64, height: 64)
                        )
                }

                Spacer()
            }
        }
    }
}

#Preview {
    HomeView(path: .constant(NavigationPath()))
}
