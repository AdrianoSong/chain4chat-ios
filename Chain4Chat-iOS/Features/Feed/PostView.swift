//
//  PostView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 14/11/23.
//

import SwiftUI

struct PostView: View {
    let user: User?
    let post: Post
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                AvatarView(
                    urlString: user?.avatar ?? "https://api.dicebear.com/7.x/bottts/jpeg?seed=Angel&backgroundColor=transparent",
                    size: 50,
                    topPadding: 0
                )
                Spacer()
            }
            .padding(.top, 16)
            .padding(.leading, 8)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(user?.name ?? "")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .padding(.trailing, 16)
                }
                Text("\(post.createdAt.toDate().toTimeAgo())")
                Text(post.message)
                    .lineLimit(3)
                HStack(spacing: 24) {
                    HStack {
                        Image(systemName: "heart")
                        Text("12")
                    }
                    
                    HStack {
                        Image(systemName: "message")
                        Text("20")
                    }
                    
                    HStack {
                        Image(systemName: "arrowshape.turn.up.forward")
                        Text("Share")
                    }
                }
            }
            .padding(.vertical, 16)
            
            Spacer()
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(25)
        .padding(.bottom, 8)
    }
}

#Preview {
    PostView(
        user: User(
            name: "name",
            bio: "bio",
            avatar: "avatar",
            postsCID: []
        ),
        post: Post(
            id: 1,
            createdAt: 123,
            updatedAt: 123,
            message: "Fist post here!!"
        )
    )
}
