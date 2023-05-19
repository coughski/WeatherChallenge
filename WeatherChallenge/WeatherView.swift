//
//  WeatherView.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let weather = viewModel.weather {
                        if weather.weather.count > 0 {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png"))
                        }
                        
                        Text(weather.main.temp, format: .number)
                            .font(.title)
                        Text("\(weather.name), \(weather.sys.country)")
                        Text(weather.date, format: .dateTime)
                    } else {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("No weather data")
                    }
                }
                .padding()
            }
            .refreshable {
                await viewModel.fetchWeatherData()
            }
            .searchable(text: $viewModel.search)
        }
        .task {
            await viewModel.fetchWeatherData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
