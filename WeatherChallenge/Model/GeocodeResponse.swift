//
//  GeocodeResponse.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import Foundation

typealias GeocodeResponse = [Geocode]

struct Geocode: Codable {
    let lat, lon: Double
    
    enum CodingKeys: CodingKey {
        case lat, lon
    }
}
