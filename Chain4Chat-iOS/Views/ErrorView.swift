//
//  ErrorView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import SwiftUI

struct ErrorView: View {
    var onTryAgainButtonTapped: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "icloud.slash")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
            Text("Oopss! Something is wrong")
                .font(.headline)
            Button("try again?", action: {
                onTryAgainButtonTapped()
            })
        }
    }
}

#Preview {
    ErrorView(onTryAgainButtonTapped: {})
}
