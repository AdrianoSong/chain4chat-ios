//
//  Chain4Chat_iOSApp.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 03/11/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct Chain4Chat_iOSApp: App {
    @State private var route: AppRouter = .onboarding
    @State private var homeUser: User?
    
    @Dependency(\.userDefaultsClient) private var userDefaultsClient
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                OnboardingView(
                    store: .init(
                        initialState: OnboardingFeature.State(),
                        reducer: {
                            OnboardingFeature(onFinished: {
                                route = .login
                            })
                        }
                    )
                )
                .animation(.smooth, value: route)
                .opacity(route == .onboarding ? 1 : 0)
                
                HomeView(
                    store: .init(
                        initialState: HomeFeature.State(
                            user: homeUser,
                            feedState: FeedFeature.State(
                                user: homeUser
                            ),
                            profileState: ProfileFeature.State(user: homeUser)
                        ),
                        reducer: {
                            HomeFeature()
                        }
                    )
                )
                .opacity(route == .home ? 1 : 0)
                .animation(.smooth, value: route)
                
                LoginView(store: .init(initialState: LoginFeature.State(userHash: ""), reducer: {
                    LoginFeature(onLoginFinished: { user in
                        route = .home
                        homeUser = user
                    })
                }))
                .opacity(route == .login ? 1 : 0)
                .animation(.smooth, value: route)
            }
        }
    }
}
