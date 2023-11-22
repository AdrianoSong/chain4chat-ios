//
//  FeedFeature.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 14/11/23.
//

import Foundation
import ComposableArchitecture

struct FeedFeature: Reducer {
    
    struct State {
        var viewState: AppViewState = .loading
        var user: User?
        var posts: IdentifiedArrayOf<Post> = []
    }
    
    enum Action {
        case fetchPosts(userPosts: [String])
        case handlePost(post: Post)
        case fetchPostsError
    }
    
    @Dependency(\.postClient) private var postClient
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchPosts(let userPosts):
            return .run { send in
                do {
                    for cid in userPosts {
                        let post = try await postClient.getPost(cid)
                        await send(.handlePost(post: post))
                    }
                } catch {
                    print("Fetch post error")
                    await send(.fetchPostsError)
                }
            }
        case .handlePost(post: let post):
            state.posts.append(post)
            state.posts.sort(by: { $0.id > $1.id })
            state.viewState = .loaded
            return .none
        case .fetchPostsError:
            state.viewState = .error
            return .none
        }
    }
}

extension FeedFeature.State: Equatable { }
