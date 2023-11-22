//
//  Date+Extennsiojn.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 15/11/23.
//

import Foundation

extension Date {
    func toTimeAgo() -> String {
        let now = Date()
        
        let secondsAgo = Int(now.timeIntervalSince(self))
        let minutes = secondsAgo / 60
        let hours = minutes / 60
        let days = hours / 24
        
        if secondsAgo < 60 {
            return "\(secondsAgo) seconds ago"
        } else if minutes < 60 {
            return "\(minutes) minutes ago"
        } else if hours < 24 {
            return "\(hours) hours ago"
        } else if days == 1 {
            return "yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E d MMM"
            return dateFormatter.string(from: self)
        }
    }
}
