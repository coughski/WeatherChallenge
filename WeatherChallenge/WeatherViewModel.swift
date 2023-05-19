//
//  WeatherViewModel.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import SwiftUI

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: WeatherResponse?
    @Published var geocodes: GeocodeResponse?
    @Published var search = ""
    
    func fetchWeatherData() async {
        let lat, lon: Double
        if let geocodes, !geocodes.isEmpty {
            lat = geocodes[0].lat
            lon = geocodes[0].lon
        } else {
            lat = 44.34
            lon = 10.99
        }
        
        weather = try? await NetworkingManager.shared.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=90231232321e8908510b11ed59344b46&units=imperial")
    }
    
    func fetchGeocodeData() async {
        if !search.isEmpty {
            geocodes = try? await NetworkingManager.shared.request("https://api.openweathermap.org/geo/1.0/direct?q=\(search)&appid=90231232321e8908510b11ed59344b46")
        }
    }
    
    private static let lastWeatherKey = "lastWeatherCoords"
    
    func save() {
        let encoded = try? JSONEncoder().encode(geocodes)
        UserDefaults.standard.setValue(encoded, forKey: Self.lastWeatherKey)
    }
    
    func load() {
        let data = UserDefaults.standard.data(forKey: Self.lastWeatherKey)
        geocodes = try? JSONDecoder().decode(GeocodeResponse.self, from: data ?? Data())
    }
}
