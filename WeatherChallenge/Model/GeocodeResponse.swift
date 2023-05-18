//
//  GeocodeResponse.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import Foundation

struct GeocodeResponse: Codable {
    let geocodes: [Geocode]
}

struct Geocode: Codable {
    let lat, lon: Double
    
    enum CodingKeys: CodingKey {
        case lat, lon
    }
}
