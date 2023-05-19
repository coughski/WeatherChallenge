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
                        HStack {
                            VStack {
                                if weather.weather.count > 0 {
                                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png"))
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text(Measurement(value: weather.main.temp, unit: UnitTemperature.fahrenheit).converted(to: UnitTemperature(forLocale: .current)).formatted())
                                    .font(.title)
                                HStack {
                                    Text(Measurement(value: weather.main.tempMin, unit: UnitTemperature.fahrenheit).converted(to: UnitTemperature(forLocale: .current)).formatted())
                                    Text(Measurement(value: weather.main.tempMax, unit: UnitTemperature.fahrenheit).converted(to: UnitTemperature(forLocale: .current)).formatted())
                                }
                                Text(weather.weather[0].description.capitalized)
                                Text("\(weather.name), \(weather.sys.country)")
                                
                                Text(weather.sys.sunrise, format: .dateTime)
                                Text(weather.sys.sunset, format: .dateTime)
                                
                                Text(weather.date, format: .dateTime)
                            }
                        }
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
            viewModel.load()
            await viewModel.fetchWeatherData()
        }
        .task(id: viewModel.search) {
            try? await Task.sleep(for: .seconds(1))
            await viewModel.fetchGeocodeData()
            await viewModel.fetchWeatherData()
            viewModel.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
