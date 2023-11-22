//
//  CustomTabBarView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 09/11/23.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var allTab: [AnimatedTab]
    @Binding var activateTab: Tab
    
    var body: some View {
        HStack {
            ForEach($allTab) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .symbolEffect(.bounce, value: animatedTab.isAnimating )
                    
                    Text(tab.title)
                        .textScale(.secondary)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activateTab == tab ? Color.primary : Color.gray)
                .padding(.top, 15)
                .padding(.bottom, 25)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        activateTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        // transaction solving error with 2x animations
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction, {
                            animatedTab.isAnimating = nil
                        })
                        
                    })
                }
            }
        }
        .background(.bar)
    }
}

#Preview {
    CustomTabBarView(allTab: .constant([]), activateTab: .constant(.feed))
}
