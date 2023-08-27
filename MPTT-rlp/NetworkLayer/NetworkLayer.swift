//
//  NetworkService.swift
//  MPTT-rlp
//
//  Created by DiOS on 27.08.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
}

protocol NetworkLayerProtocol {
    func fetchDataAsync<T: Decodable>(from url: URL, modelType: T.Type) async throws -> [T]
    func fetchData<T: Decodable>(from url: String, modelType: [T].Type, completion: @escaping (Result<[T], NetworkError>) -> Void)
}

class NetworkLayer: NetworkLayerProtocol {
    static let shared = NetworkLayer()
    
    private init() {}
    
    func fetchData<T: Decodable>(from url: String, modelType: [T].Type, completion: @escaping (Result<[T], NetworkError>) -> Void) {
        guard let basePlusUrl = URL(string: R.URL.baseURL + url) else { return }
        let task = URLSession.shared.dataTask(with: basePlusUrl) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let loaded = try decoder.decode([T].self, from: data)
                completion(.success(loaded))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
    
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


