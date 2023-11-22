//
//  UserDefaultsClient.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 06/11/23.
//

import Foundation
import ComposableArchitecture

enum UserDefaultsKey: String {
    case firstAccess
    case user
}

struct UserDefaultsClient {
    var isFirstAppAccess: () -> Bool
    var setFirstAppAccess: (Bool) -> Void
    var setUset: (User) -> Void
    var getUser: () -> User?
}

extension UserDefaultsClient: DependencyKey {
    static var liveValue = Self(
        isFirstAppAccess: {
            return !UserDefaults.standard.bool(forKey: UserDefaultsKey.firstAccess.rawValue)
        },
        setFirstAppAccess: { newValue in
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKey.firstAccess.rawValue)
        }, setUset: { newUser in
            do {
                let encoded = try JSONEncoder().encode(newUser)
                UserDefaults.standard.set(encoded, forKey: UserDefaultsKey.user.rawValue)
            } catch {
                print("encoded error")
            }
        }, getUser: {
            do {
                if let savedData = UserDefaults.standard.data(forKey: UserDefaultsKey.user.rawValue) {
                    let user = try JSONDecoder().decode(User.self, from: savedData)
                    return user
                } else {
                    print("decode error")
                    return nil
                }
            } catch {
                print("decode error")
                return nil
            }
        })
}

extension DependencyValues {
    var userDefaultsClient: UserDefaultsClient {
        get { self[UserDefaultsClient.self] }
        set { self[UserDefaultsClient.self] = newValue }
    }
}
