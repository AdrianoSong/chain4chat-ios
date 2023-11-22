//
//  Post.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import Foundation
import SwiftUI

struct Post: Codable, Identifiable  {
    let id: Int
    let createdAt: Int
    let updatedAt: Int
    let message: String
}

extension Post: Equatable { }
