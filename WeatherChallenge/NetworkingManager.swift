//
//  NetworkingManager.swift
//  WeatherChallenge
//
//  Created by Kuba Szulaczkowski on 5/18/23.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    private init() {}
    
    func request<T: Decodable>(_ urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw NetworkingError.invalidURL }
        
        let result: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let data = try decoder.decode(T.self, from: result.data)
            return data
        } catch {
            throw NetworkingError.failedToDecode
        }
    }
    
    enum NetworkingError: Error {
        case invalidURL
        case failedToDecode
    }
}
