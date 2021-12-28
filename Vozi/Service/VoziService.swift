//
//  VoziService.swift
//  Vozi
//
//  Created by Todd Meng on 12/24/21.
//

import Foundation
import Combine

protocol VoziService {
    func request(from endpoint: VoziAPI)
//    func uploadFile(at fileURL: URL,
//                        to endpoint: VoziAPI) -> AnyPublisher<Double, Error>
}


class VoziServiceImpl: NSObject, VoziService {
    // Function for making a basic API request
    func request(from endpoint: VoziAPI) {
        let task = URLSession.shared.uploadTask(with: endpoint.urlRequest, fromFile: endpoint.fileURL)
        task.resume()
//        return URLSession.shared
//            .dataTaskPublisher(for: endpoint.urlRequest)
//            .receive(on: DispatchQueue.main)
//            .mapError {_ in APIError.unknown }
//            .flatMap{ data, response -> AnyPublisher<VoziResponse, APIError> in
//
//                guard let response = response as? HTTPURLResponse else {
//                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
//                }
//
//                if (200...299).contains(response.statusCode) {
//                    return Just(data).decode(type: VoziResponse.self, decoder: JSONDecoder())
//                        .mapError{_ in APIError.decodingError}
//                        .eraseToAnyPublisher()
//                } else {
//                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
//                }
//            }
//            .eraseToAnyPublisher()
    }
    
    
    // function for uploading a file

//    typealias Publisher = AnyPublisher<VoziResponse, APIError>
//    func uploadFile(at fileURL: URL,
//                        to endpoint: VoziAPI) -> Publisher {
//        let request = endpoint.urlRequest
//
//        let task = URLSession.shared.uploadTask(
//                with: request,
//                fromFile: fileURL,
//                completionHandler: { data, response, error in
//                    // Validate response and send completion
//
//                }
//            )
//
//            task.resume()
//
//    }
    
    
}
