//
//  HomeFeature.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import Foundation
import ComposableArchitecture
import UIKit

enum Tab: String, CaseIterable, Hashable {
    case feed = "house.fill"
    case profile = "person.crop.circle"
    
    var title: String {
        switch self {
        case .feed:
            return "Feed"
        case .profile:
            return "Profile"
        }
    }
}

struct AnimatedTab: Identifiable {
    var id: UUID = UUID()
    var tab: Tab
    var isAnimating: Bool?
}

struct HomeFeature: Reducer {
    struct State {
        var user: User?
        var activeTab: Tab = .feed
        var feedState: FeedFeature.State
        var profileState: ProfileFeature.State
    }
    
    enum Action {
        case updateActivaTab(Tab)
        case feedAction(FeedFeature.Action)
        case profileAction(ProfileFeature.Action)
    }
    
    @Dependency(\.postClient) private var postClient
    
    // here is the combination of Reducers (Feed and Profile into Home)
    var body: some Reducer<State, Action> {
        Scope(
            state: \.feedState,
            action: /Action.feedAction,
            child: {
                FeedFeature()
            }
        )
        
        Scope(
            state: \.profileState,
            action: /Action.profileAction,
            child: {
                ProfileFeature()
            })
    }
        
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .updateActivaTab(let tab):
            state.activeTab = tab
            return .none
        // Here is the feed actions (re-implement the same from FeedFeature.Action)
        case .feedAction(.fetchPosts(userPosts: let userPosts)):
            return .run { send in
                do {
                    for cid in userPosts {
                        let post = try await postClient.getPost(cid)
                        await send(.feedAction(.handlePost(post: post)))
                    }
                } catch {
                    print("Fetch post error")
                    await send(.feedAction(.fetchPostsError))
                }
            }
        case .feedAction(.handlePost(let post)):
            state.feedState.posts.append(post)
            state.feedState.posts.sort(by: { $0.id > $1.id })
            state.feedState.viewState = .loaded
            return .none
        case .feedAction(.fetchPostsError):
            state.feedState.viewState = .error
            return .none
            
        // Here is the profile actions (re-implement the same from ProfileFeature.Action)
        case .profileAction(.toogleShowHash):
            state.profileState.showHash.toggle()
            return .none
        case .profileAction(.copyToClipboard(let hash)):
            let pasteboard = UIPasteboard.general
            pasteboard.string = hash
            return .none
        }
    }
}

extension HomeFeature.State: Equatable { }
