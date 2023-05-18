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
        VStack {
            if let weather = viewModel.weather {
                Text("\(weather.name), \(weather.sys.country)")
                Text("\(weather.main.temp)")
                Text("\(weather.date)")
            } else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("No weather data")
            }
        }
        .padding()
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
