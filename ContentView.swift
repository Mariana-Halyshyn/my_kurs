import SwiftUI

struct ContentView: View {
    @StateObject var weatherVM = WeatherViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()
    
    // Стан для програмного керування активною вкладкою 
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            //фон градієнт ПЕРЕВІРИТИ
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
    
            TabView(selection: $selectedTab) {
                
                //Погода
                WeatherDetailView(viewModel: weatherVM, favoritesVM: favoritesVM)
                    .tabItem {
                        Label("Погода", systemImage: "cloud.sun.fill")
                    }
                    .tag(0)
                
                // Улюблені
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

