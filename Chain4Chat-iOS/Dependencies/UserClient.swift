//
//  UserRegistrationClient.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import Foundation
import ComposableArchitecture

struct UserClient {
    var getUser: (String) async throws -> User
    var createUser: (User) async throws -> UserResponse
}

extension UserClient: DependencyKey {
    static var liveValue = Self(
        getUser: { userHash in
            let user: User = try await API.request(endpoint: .getUser(cid: userHash))
            return user
        }, createUser: { user in
            let userResponse: UserResponse = try await API.request(endpoint: .createUser(user: user))
            return userResponse
        }
    )
}

extension DependencyValues {
    var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }
}
