


import SwiftUI

struct ContentView: View {
    @StateObject private var weatherVM = WeatherViewModel()
    @StateObject private var favoritesVM = FavoritesViewModel()
    @State private var selectedTab: Tab = .weather

    enum Tab: Int { case weather, favorites }

    var body: some View {
        HStack(spacing: 0) {
            // Sidebar TabBar
            VStack(spacing: 20) {
                Button(action: { selectedTab = .weather }) {
                    Image(systemName: "cloud.sun")
                        .font(.system(size: 24))
                }
                .padding()

                Button(action: { selectedTab = .favorites }) {
                    Image(systemName: "star")
                        .font(.system(size: 24))
                }
                .padding()

                Spacer()
            }
            .frame(width: 70)
            .background(Color(white: 0.92))

            // Main Content
            ZStack {
                Color(white: 0.97).ignoresSafeArea()

                if selectedTab == .weather {
                    WeatherMainView(viewModel: weatherVM, favoritesVM: favoritesVM)
                } else {
                    FavoritesListView(favoritesVM: favoritesVM) { city in
                        weatherVM.fetchWeather(cityName: city, lat: nil, lon: nil)
                        selectedTab = .weather
                    }
                }
            }
        }
        .onAppear {
            if weatherVM.currentWeather == nil {
                weatherVM.requestLocationIfNeeded()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View { ContentView() }
}
