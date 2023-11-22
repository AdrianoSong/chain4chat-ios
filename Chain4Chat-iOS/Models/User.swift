//
//  User.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import Foundation

struct User: Codable {
    let name: String
    let bio: String
    let avatar: String
    let postsCID: [String]
    var hash: String = ""
    
    enum CodingKeys: CodingKey {
        case name
        case bio
        case avatar
        case postsCID
    }
}

extension User: Equatable { }

struct UserResponse: Codable {
    let success: Bool
    let cid: String
}
