//
//  WeatherView.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import SwiftUI
import CoreLocationUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if let weather = viewModel.weather {
                        HStack(alignment: .lastTextBaseline) {
                            VStack(alignment: .leading) {
                                if weather.weather.count > 0 {
                                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png"))
                                }
                                
                                Text(weather.weather[0].description.capitalized)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(Measurement(value: weather.main.temp, unit: UnitTemperature.fahrenheit).formatted())
                                    .font(.largeTitle)
                                
                                HStack {
                                    Text(Measurement(value: weather.main.tempMin, unit: UnitTemperature.fahrenheit).formatted())
                                    Text(Measurement(value: weather.main.tempMax, unit: UnitTemperature.fahrenheit).formatted())
                                }
                                
                                Group {
                                    
                                    Text("\(weather.name), \(weather.sys.country)")
                                }
                                
                                Text(weather.date, format: .dateTime.hour().minute())
                            }
                            
                            VStack(alignment: .leading) {
                                Group {
                                    HStack {
                                        Image(systemName: "cloud")
                                        Text(weather.clouds.all, format: .percent)
                                    }
                                    
                                    HStack {
                                        Image(systemName: "wind")
                                        Text(Measurement(value: weather.wind.speed, unit: UnitSpeed.milesPerHour).formatted())
                                    }
                                    
                                    HStack {
                                        Image(systemName: "humidity")
                                            .symbolRenderingMode(.hierarchical)
//                                            .foregroundStyle(.teal, .primary)
                                        Text(weather.main.humidity, format: .percent)
                                    }
                                    
                                    HStack {
                                        Image(systemName: "eye")
                                        Text(Measurement(value: Double(weather.visibility), unit: UnitLength.meters).formatted())
                                    }
                                }
                                
                                HStack {
                                    Label {
                                        Text("Sunrise")
                                    } icon: {
                                        Image(systemName: "sunrise")
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.primary, .red)
                                    }
                                    .labelStyle(.iconOnly)
                                    Text(weather.sys.sunrise, format: .dateTime.hour().minute())
                                }
                                
                                HStack {
                                    Label {
                                        Text("Sunset")
                                    } icon: {
                                        Image(systemName: "sunset")
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.primary, .red)
                                    }
                                    .labelStyle(.iconOnly)
                                    Text(weather.sys.sunset, format: .dateTime.hour().minute())
                                }
                            }
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(.secondary, lineWidth: 0.5)
                        }
                    } else {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Weather data unavailable")
                    }
                    
                    LocationButton {
                        locationManager.requestLocation()
                    }
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.top)
                }
                .padding()
            }
            .refreshable { await viewModel.fetchWeatherData() }
            .searchable(text: $viewModel.search)
        }
        .task {
            viewModel.load()
            await viewModel.fetchWeatherData()
        }
        .task(id: viewModel.search) {
            try? await Task.sleep(for: .seconds(1))
            await viewModel.fetchGeocodeData()
            viewModel.save()
            await viewModel.fetchWeatherData()
        }
        .onChange(of: locationManager.location) { location in
            if let location {
                viewModel.geocodes = [Geocode(lat: location.latitude, lon: location.longitude)]
                viewModel.save()
                Task {
                    await viewModel.fetchWeatherData()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
