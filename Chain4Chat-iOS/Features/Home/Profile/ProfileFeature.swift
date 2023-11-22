//
//  ProfileFeature.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 09/11/23.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct ProfileFeature: Reducer {
    struct State {
        var user: User?
        var showHash = false
    }
    
    enum Action {
        case toogleShowHash
        case copyToClipboard(String)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .toogleShowHash:
            withAnimation {
                state.showHash.toggle()
            }
            return .none
        case .copyToClipboard(let hash):
            let pasteboard = UIPasteboard.general
            pasteboard.string = hash
            return .none
        }
    }
}

extension ProfileFeature.State: Equatable { }
