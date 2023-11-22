//
//  OnboardingItemView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 06/11/23.
//

import SwiftUI

struct OnboardingItemView: View {
    let title: String
    let description: String
    let imageName: String
    var hasConfirmationButton: Bool = false
    var confirmationButtonTapped: (() -> Void)?
    
    @State private var animate = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .symbolEffect(.bounce, value: animate)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            if hasConfirmationButton {
                
                CustomButtonView(
                    title: "Let's go!",
                    buttonTapped: {
                        confirmationButtonTapped?()
                })
            }
            
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            animate.toggle()
        })
    }
}

#Preview {
    OnboardingItemView(
        title: "Item",
        description: "Onboarding item descer",
        imageName: "lock.fill",
        hasConfirmationButton: true
    )
}
