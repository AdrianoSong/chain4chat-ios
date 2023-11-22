//
//  OnboardingView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 06/11/23.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingView: View {
    
    let store: StoreOf<OnboardingFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView {
                OnboardingItemView(
                    title: "Privacy & Security",
                    description: "There is no central authority, no one can change any caracteristics of the network.",
                    imageName: "lock.fill"
                )
                OnboardingItemView(
                    title: "Decentralized",
                    description: "Decentralized network makes you invisible to governments once we can't store your IP.",
                    imageName: "cloud.fill"
                )
                OnboardingItemView(
                    title: "Can't be corrupted",
                    description: "All node in the network has a copy of your data, so one can't corrupt your data, but remember anyone who possess your hash can see your data, so be careful.",
                    imageName: "folder.fill"
                )
                
                OnboardingItemView(
                    title: "Let's go!",
                    description: "Are you ready to experience Web3 network?",
                    imageName: "door.left.hand.open",
                    hasConfirmationButton: true,
                    confirmationButtonTapped: {
                        viewStore.send(.finishOnboarding)
                    }
                )
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        
    }
}

#Preview {
    OnboardingView(store: .init(initialState: OnboardingFeature.State(), reducer: {
        OnboardingFeature(onFinished: {})
    }))
}
