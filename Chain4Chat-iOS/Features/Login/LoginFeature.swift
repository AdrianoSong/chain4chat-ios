//
//  LoginFeature.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import Foundation
import ComposableArchitecture

struct LoginFeature: Reducer {
    struct State {
        var userHash: String
        var viewState: AppViewState = .loaded
    }
    
    enum Action {
        case performLogin(String)
        case updateUserHash(String)
        case handleUser(User)
        case loginError
    }
    
    @Dependency(\.userClient) private var userClient
    @Dependency(\.userDefaultsClient) private var userDefaultsClient
    
    var onLoginFinished: (User) -> Void
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .performLogin(userHash):
            state.viewState = .loading
            return .run { send in
                do {
                    let user = try await userClient.getUser(userHash)
                    await send(.handleUser(user))
                } catch let error {
                    print("Login error: \(error)")
                    await send(.loginError)
                }
            }
        case let .updateUserHash(userHash):
            state.userHash = userHash
            return .none
        case let .handleUser(user):
            var handleUser = user
            handleUser.hash = state.userHash
            state.viewState = .loaded
            onLoginFinished(handleUser)
            userDefaultsClient.setUset(handleUser)
            return .none
        case .loginError:
            state.viewState = .error
            print("error")
            return .none
        }
    }
}

extension LoginFeature.State : Equatable {}
