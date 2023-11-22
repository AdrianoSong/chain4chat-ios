//
//  FeedView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 08/11/23.
//

import SwiftUI
import ComposableArchitecture

struct FeedView: View {
    
    let store: StoreOf<FeedFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }, content: { viewStore in
            ZStack {
                loading(viewStore: viewStore)
                
                loaded(viewStore: viewStore)
            }
        })
    }
    
    private func loading(viewStore: ViewStore<FeedFeature.State, FeedFeature.Action>) -> some View {
        ZStack {
            
            Color.clear
            
            LoadingView()
        }
        .animation(.smooth, value: viewStore.viewState)
        .opacity(viewStore.viewState == .loading ? 1.0 : 0.0)
    }
    
    private func loaded(viewStore: ViewStore<FeedFeature.State, FeedFeature.Action>) -> some View {
        ZStack {
            Color.clear
            GeometryReader {geo in
                ScrollView(showsIndicators: false) {
                    ForEach(viewStore.posts) { post in
                        PostView(user: viewStore.user, post: post)
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FloatingButtonView()
                }
                .padding()
            }
        }
        .animation(.smooth, value: viewStore.viewState)
        .opacity(viewStore.viewState == .loaded ? 1.0 : 0.0)
        .onChange(of: viewStore.user?.postsCID ?? [], { _, newValue in
            viewStore.send(.fetchPosts(userPosts: newValue))
        })
    }
}

#Preview {
    FeedView(store: .init(initialState: FeedFeature.State(user: User(name: "name", bio: "bio", avatar: "avatar", postsCID: [])), reducer: {
        FeedFeature()
    }))
}
