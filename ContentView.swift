import SwiftUI

struct ContentView: View {
    @StateObject var weatherVM = WeatherViewModel()
    @StateObject var favoritesVM = FavoritesView() //змінити назву змінної в іншомув коді
    
    // Стан для програмного керування активною вкладкою
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Простий нейтральний фон
            Color(.systemBackground)
                .ignoresSafeArea()
            
            // TabView для навігації
            TabView(selection: $selectedTab) {
                
                // Вкладка "Погода"
                WeatherDetailView(viewModel: weatherVM, favoritesVM: favoritesVM)
                    .tabItem {
                        Label("Погода", systemImage: "cloud.sun.fill")
                    }
                    .tag(0)
                
                // Вкладка "Улюблені"
                FavoritesView(
                    favoritesVM: favoritesVM,
                    weatherVM: weatherVM,
                    onCitySelect: { selectedCity in
                        weatherVM.fetchWeather(city: selectedCity, lat: nil, lon: nil)
                        selectedTab = 0
                    }
                )
                .tabItem {
                    Label("Улюблені", systemImage: "list.star")
                }
                .tag(1)
            }
            .tint(.orange)
        }
    }
}
