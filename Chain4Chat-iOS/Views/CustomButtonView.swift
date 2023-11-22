//
//  CustomButtonView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 06/11/23.
//

import SwiftUI

struct CustomButtonView: View {
    let title: String
    var buttonTapped: () -> Void
    
    var body: some View {
        Button(action: {
            buttonTapped()
        }, label: {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(.background)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 2)
                )
                
        })
        .padding(.top, 16)
    }
}

#Preview {
    CustomButtonView(title: "Test", buttonTapped: {})
}
