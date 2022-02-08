//
//  VoziViewModel.swift
//  Vozi
//
//  Created by Todd Meng on 12/25/21.
//

import Foundation
import Combine
import AVFoundation



class VoziViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    private let service : VoziServiceImpl
    lazy var uploadSession: URLSession = {
            let configuration = URLSessionConfiguration.default
            return URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
        }()
    
    @Published internal var state: ResultState = .resting
    
    
    
    private var cancellables = Set<AnyCancellable>()
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    let audioFilename: URL
    var audioPlayer: AVAudioPlayer!
    
    init(service: VoziServiceImpl) {
        self.service = service
        self.audioFilename = VoziViewModel.getDocumentsDirectory().appendingPathComponent("recording.m4a")
    }
    
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    internal func startRecording() {
        
        self.recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                if !allowed {
                    return
                }
            }
        }
        catch {
            self.state = .Failed(error: error)
        }
        self.state = .recording
        print("started recording")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            if FileManager.default.fileExists(atPath: audioFilename.path) {
                try FileManager.default.removeItem(atPath: audioFilename.path)
            }
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            self.state = .Failed(error: error)
            print("failed")
        }
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    
    private func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        if !success {
            print("failed to record")
            self.state = .resting
            return
        }
        print("stopping recording")
        self.state = .playing
    }
    
    
    func playRecording() {
        do {
            if audioPlayer == nil {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                audioPlayer.delegate = self
            }
            audioPlayer.play()
            print("playing recording")
        } catch {
            self.state = .Failed(error: error)
            print("failed")
        }
        
    }
    
    func goBack() {
        self.service.cancelTask()
        audioPlayer = nil
        audioRecorder = nil
        self.state = .resting
    }
    
    
    func sendRecording() {
        self.state = .waitingResponse
        self.service.session = uploadSession
        self.service.request(from: .getSong(fileUrl: audioFilename))
    }
    
    
    
    
    
    
    
    private static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


