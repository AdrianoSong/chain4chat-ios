//
//  FloatingButtonView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 09/11/23.
//

import SwiftUI

struct FloatingButtonView: View {
    var body: some View {
            Button(action: {
                print("Button tapped!")
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
            .frame(width: 50, height: 50)
            .background(Color.white)
            .clipShape(Circle())
        }
}

#Preview {
    FloatingButtonView()
}
