//
//  VoziService.swift
//  Vozi
//
//  Created by Todd Meng on 12/24/21.
//

import Foundation
import Combine

//protocol VoziService {
//    func request(from endpoint: VoziAPI, completionHandler: (Data?, URLResponse?, Error?) -> Void)
//}


class VoziServiceImpl {
    
    var session: URLSession!
    private var task: URLSessionUploadTask? = nil
    
    // Function for making a basic API request
    func request(from endpoint: VoziAPI) {
        self.task = self.session.uploadTask(with: endpoint.urlRequest, fromFile: endpoint.fileURL!)
        if task != nil { task!.resume() }
    }
    
    func cancelTask() {
        if task != nil {
            task?.cancel()
            task = nil
        }
    }
}

extension VoziViewModel: URLSessionDataDelegate {
    // Error received
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let err = error {
            print("Error: \(err.localizedDescription)")
            self.state = .Failed(error: err)
        }
    }

    // Response received
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: (URLSession.ResponseDisposition)-> Void) {
        completionHandler(URLSession.ResponseDisposition.allow)
    }

    // Data received
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // Convert to JSON
        do {
            if FileManager.default.fileExists(atPath: self.audioFilename.path) {
                try FileManager.default.removeItem(atPath: self.audioFilename.path)
            }
            try data.write(to: URL(string: "file://" + self.audioFilename.path)!)
            self.state = .success
        } catch {
            self.state = .Failed(error: error)
        }
       
    }
}

