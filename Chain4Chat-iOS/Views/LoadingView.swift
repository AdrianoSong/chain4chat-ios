//
//  LoadingView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(3)
            .padding()
    }
}

#Preview {
    LoadingView()
}

