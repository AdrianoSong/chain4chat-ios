//
//  UserRegistrationFeature.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 06/11/23.
//

import SwiftUI
import ComposableArchitecture

struct UserRegistrationFeature: Reducer {
    struct State {
        var name: String
        var bio: String
        var viewState: AppViewState = .loaded
    }
    
    enum Action {
        case updateName(String)
        case updateBio(String)
        case performRegistration
        case registrationSuccess(UserResponse)
        case registrationError
    }
    
    var registrationCID: (String) -> Void
    
    @Dependency(\.userClient) private var userClient
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .updateName(let newValue):
            state.name = newValue
            return .none
        case .updateBio(let newValue):
            state.bio = newValue
            return .none
        case .performRegistration:
            let name = state.name
            let bio = state.bio
            state.viewState = .loading
            return .run { send in
                do {
                    let user = User(
                        name: name,
                        bio: bio,
                        avatar: "//https://api.dicebear.com/7.x/bottts/svg?seed=\(name)",
                        postsCID: []
                    )
                    let userResponse = try await userClient.createUser(user)
                    await send(.registrationSuccess(userResponse))
                } catch let error {
                    print("Login error: \(error)")
                    await send(.registrationError)
                }
            }
            
        case .registrationSuccess(let userResponse):
            registrationCID(userResponse.cid)
            return .none
        case .registrationError:
            state.viewState = .error
            return .none
        }
    }
}

extension UserRegistrationFeature.State: Equatable {
    static func == (lhs: UserRegistrationFeature.State, rhs: UserRegistrationFeature.State) -> Bool {
        lhs.name == rhs.name
    }
}
