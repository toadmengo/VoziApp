//
//  RecordingView.swift
//  Vozi
//
//  Created by Todd Meng on 12/26/21.
//

import SwiftUI

struct RecordingView: View {
    
    @StateObject var viewModel = VoziViewModel(service: VoziServiceImpl())
    
    var body: some View {
        Group {
            switch viewModel.state {
                
            case .Failed(error: let error):
                VStack {
                    Button("Go back", action: viewModel.goBack).padding()
                    Text(error.localizedDescription).padding()
                }
            
            case .recording:
                HStack {
                    Button("Stop Recording", action: viewModel.recordTapped)
                }
            
            case .playing:
                VStack {
                    PlayRecordingView(viewModel: viewModel)
                    Button("Submit Recording", action: viewModel.sendRecording).padding()
                }
            case .resting:
                HStack {
                    Button("Start Recording", action: viewModel.recordTapped)
                }
            case .success:
                VStack {
                    PlayRecordingView(viewModel: viewModel)
                    Text("Upload succesful!").padding()
                }
            case .waitingResponse:
                VStack {
                    Button("Go back", action: viewModel.goBack).padding()
                    Text("Uploading audio....").padding()
                }
            }
            
        }
    }
}

struct PlayRecordingView : View {
    var viewModel: VoziViewModel
    var body: some View {
        VStack {
            Button("Go back", action: viewModel.goBack).padding()
            Button("Play Recording", action: viewModel.playRecording).padding()
        }
    }
}










struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
