//
//  NetworkError.swift
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
