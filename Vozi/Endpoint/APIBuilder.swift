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
    var fileURL: URL { get }
}

enum VoziAPI {
    case getSong(fileUrl: URL)
}

struct Req {
    let request : URLRequest
    let data : Data
}

extension VoziAPI: APIBuilder {
    
    
    var urlRequest: URLRequest {
        let request = URLRequest(url: self.baseURL.appendingPathComponent(self.path))
//        switch self {
//        case .getSong(let fileURL):
//            // generate boundary string using a unique string
//            let boundary = UUID().uuidString
//
//            let data = getBody(boundary: boundary, fileURL: fileURL)
//
//            // Set the URLRequest to POST and to the specified URL
//            request.httpMethod = "POST"
//    //        request.addValue("Bearer \(yourAuthorizationToken)", forHTTPHeaderField: "Authorization")
//
//            // Content-Type is multipart/form-data, this is the same as submitting form data with file upload
//            // in a web browser
//            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//            // do not forget to set the content-length!
//            request.setValue(String(data.count), forHTTPHeaderField: "Content-Length")
//            // session.uploadTask(with: request, from: data)
//            return Req(request: request, data: data)
//        }
        return request
    }

    var baseURL: URL {
        switch self {
        case .getSong:
            return URL(string: "http://toadmangopython.pythonanywhere.com")!
        }
    }

    var path: String {
        switch self {
        case .getSong:
            return "/getSong"
        }
    }
  
    var fileURL: URL {
        switch self {
        case .getSong(fileUrl: let url):
            return url
        }
    }
    
//    func getBody(boundary: String, fileURL: URL) -> Data {
//        let fileName = fileURL.lastPathComponent
//        let mimetype = mimeType(for: fileName)
//        let paramName = "file"
//        let fileData = try? Data(contentsOf: fileURL)
//        var data = Data()
//        // Add the file data to the raw http request data
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
//                data.append(fileData!)
//                data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//        return data
//    }
//
//    private func mimeType(for path: String) -> String {
//        // this solution may not actually work
//            return "application/octet-stream"
//
//        }
    
}
