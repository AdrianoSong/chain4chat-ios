//
//  OnboardingFeature.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 06/11/23.
//

import Foundation
import ComposableArchitecture

struct OnboardingFeature: Reducer {
    struct State {
        
    }
    
    enum Action {
        case finishOnboarding
    }
    
    @Dependency(\.userDefaultsClient) private var userDefaultsClient
    var onFinished: () -> Void
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .finishOnboarding:
            userDefaultsClient.setFirstAppAccess(true)
            onFinished()
            return .none
        }
    }
}

extension OnboardingFeature.State: Equatable { }
