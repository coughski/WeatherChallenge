//
//  WeatherViewModel.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: WeatherResponse?
}
