//
//  WeatherResponse.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import Foundation

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let date: Date
    let sys: Sys
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather, main, visibility, wind, clouds, sys, name
        case date = "dt"
    }
}

struct Clouds: Codable {
    let all: Int
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    let seaLevel, grndLevel: Int?
    
    enum CodingKeys: CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure, humidity
        case seaLevel
        case grndLevel
    }
}

struct Sys: Codable {
    let country: String
    let sunrise, sunset: Date
    
    enum CodingKeys: CodingKey {
        case country, sunrise, sunset
    }
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}
