//
//  View+Extensions.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 09/11/23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func setupTab(tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
