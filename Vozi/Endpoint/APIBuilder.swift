//
//  APIBuilder.swift
//  Vozi
//
//  Created by Todd Meng on 12/24/21.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseURL: URL { get }
    var path: String { get }
    var fileURL: URL? { get }
}

enum VoziAPI {
    case getSong(fileUrl: URL)
    case test
}

extension VoziAPI: APIBuilder {
    
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: self.baseURL.appendingPathComponent(self.path))
        switch self {
        case .getSong(_):
            request.httpMethod = "POST"
        case .test:
            request.httpMethod = "GET"
        }
        return request
    }

    var baseURL: URL {
        return URL(string: "http://127.0.0.1:5000")!
    }

    var path: String {
        switch self {
        case .getSong:
            return "/getSong"
        case .test:
            return "/"
        }
        
    }
  
    var fileURL: URL? {
        switch self {
        case .getSong(fileUrl: let url):
            return url
        case .test:
            return nil
        }
    }

    
}
