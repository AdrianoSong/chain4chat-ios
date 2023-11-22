//
//  HomeView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 03/11/23.
//

import SwiftUI
import ComposableArchitecture

enum AppViewState {
    case loaded
    case loading
    case empty
    case error
}

struct HomeView: View {
    
    let store: StoreOf<HomeFeature>
    
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { AnimatedTab(tab: $0) }
        
    var body: some View {
        WithViewStore(store, observe: { $0 }, content: { viewStore in
            VStack {
                TabView(selection: viewStore.binding(get: \.activeTab, send: { .updateActivaTab($0) })) {
                    NavigationStack {
                        // FeedView should be instantiated as scope (combine) to preserve state from tab changing
                        FeedView(
                            store: store.scope(
                                state: \.feedState,
                                action: HomeFeature.Action.feedAction
                            )
                        )
                        
                        .navigationTitle("Hello \(viewStore.user?.name ?? "")")
                    }
                    .setupTab(tab: .feed)
                    
                    NavigationStack {
                        // Profile should be instantiated as scope (combine) to preserve state from tab changing
                        ProfileView(
                            store: store.scope(
                                state: \.profileState,
                                action: HomeFeature.Action.profileAction
                            )
                        )
                        
                        .navigationTitle("Profile")
                    }
                    .setupTab(tab: .profile)
                }
                
                CustomTabBarView(
                    allTab: $allTabs,
                    activateTab: viewStore.binding(
                        get: \.activeTab,
                        send: { .updateActivaTab($0) }
                    )
                )
            }
            .ignoresSafeArea(.all)
        })
    }
}

#Preview {
    HomeView(
        store: .init(
            initialState: HomeFeature.State(
                feedState: FeedFeature.State(),
                profileState: ProfileFeature.State()
            ),
            reducer: {
                HomeFeature()
            }
        )
    )
}
