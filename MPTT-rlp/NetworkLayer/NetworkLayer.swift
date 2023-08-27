//
//  NetworkService.swift
//  MPTT-rlp
//
//  Created by DiOS on 27.08.2023.
//

import Foundation

protocol NetworkLayerProtocol {
    func fetchDataAsync<T: Decodable>(from url: URL, modelType: T.Type) async throws -> [T]
}

class NetworkLayer: NetworkLayerProtocol {
    static let shared = NetworkLayer()
    
    private init() {}
    
    func fetchDataAsync<T: Decodable>(from url: URL, modelType: T.Type) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            let parsedData = try decoder.decode([T].self, from: data)
            
            return parsedData
        } catch {
            throw NetworkError.invalidData
        }
    }
}


