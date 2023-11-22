//
//  ProfileView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 08/11/23.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    
    let store: StoreOf<ProfileFeature>
            
    var body: some View {
        WithViewStore(store, observe: { $0 }, content: { viewStore in
            ScrollView(showsIndicators: false) {
                VStack {
                    AvatarView(
                        urlString: viewStore.user?.avatar ?? "https://api.dicebear.com/7.x/bottts/jpeg?seed=Angel&backgroundColor=transparent",
                        size: 100,
                        topPadding: 64
                    )
                    
                    Text(viewStore.user?.name ?? "No name")
                        .font(.title)
                        .padding(.bottom, 16)
                    
                    Text(viewStore.user?.bio ?? "No bio")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                    
                    Spacer()
                    
                    CustomButtonView(
                        title: viewStore.showHash ? "Hide your hash": "Show your hash (don't share it)",
                        buttonTapped: {
                            viewStore.send(.toogleShowHash)
                        }
                    )
                    
                    HStack {
                        Text(viewStore.user?.hash ?? "No hash")
                        Image(systemName: "doc.on.doc")
                    }.onTapGesture {
                        viewStore.send(.copyToClipboard(viewStore.user?.hash ?? ""))
                    }
                    .animation(.snappy, value: viewStore.showHash)
                    .opacity(viewStore.showHash ? 1.0 : 0.0)
                    .padding(.top, 16)
                    .overlay(
                        HStack {
                            Spacer()
                            Label(title: "Copied", icon: Image(systemName: "checkmark"))
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                                .cornerRadius(25)
                                .background(.gray.opacity(0.2))
                            Spacer()
                        }
                    )
                    
                    Spacer()
                }
                .padding()
            }
        })
    }
}

#Preview {
    ProfileView(store: .init(initialState: ProfileFeature.State(user: User(name: "UserName", bio: "A curious soul navigating the vast realms of knowledge and creativity. With a passion for learning that knows no bounds, [User] is always on the lookout for new ideas and perspectives. Whether immersed in the fascinating world of technology, exploring the wonders of literature, or delving into the intricacies of art, [User] approaches every endeavor with a blend of enthusiasm and open-mindedness. A seeker of inspiration and a connoisseur of all things intriguing, [User] invites you to join them on this journey of discovery and exchange of ideas.", avatar: "https://api.dicebear.com/7.x/bottts/jpeg?seed=Bot4&scale=200&backgroundColor=transparent", postsCID: [])), reducer: {
        ProfileFeature()
    }))
}
