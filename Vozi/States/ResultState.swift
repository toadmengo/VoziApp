//
//  ResultState.swift
//  Vozi
//
//  Created by Todd Meng on 12/25/21.
//

import Foundation

enum ResultState {
    case resting
    case recording
    case playing
    case waitingResponse
    case success
    case Failed(error: Error)
}
