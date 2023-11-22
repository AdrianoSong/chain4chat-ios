//
//  Int+Extension.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 15/11/23.
//

import Foundation

extension Int {
    /// From unix timestamp to Date
    func toDate() -> Date {
        let timeInterval = TimeInterval(self)
        let timestampInSeconds = timeInterval / 1000

        return Date(timeIntervalSince1970: timestampInSeconds)
    }
}
