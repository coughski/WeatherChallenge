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
    
    func fetchWeatherData() async {
        weather = try? await NetworkingManager.shared.request("https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=90231232321e8908510b11ed59344b46&units=imperial")
    }
}
