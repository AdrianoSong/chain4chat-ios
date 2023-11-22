//
//  PostClient.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 14/11/23.
//

import Foundation
import ComposableArchitecture

struct PostClient {
    var getPost: (String) async throws -> Post
}

extension PostClient: DependencyKey {
    static var liveValue = Self(
        getPost: { cid in
            let post: Post = try await API.request(endpoint: .getPost(cid: cid))
            return post
        })
}

extension DependencyValues {
    var postClient: PostClient {
        get { self[PostClient.self] }
        set { self[PostClient.self] = newValue }
    }
}
