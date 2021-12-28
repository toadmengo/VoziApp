//
//  APIError.swift
//  Vozi
//
//  Created by Todd Meng on 12/24/21.
//

import Foundation

enum APIError {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode object"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "Unknown Error"
        }
    }
}
