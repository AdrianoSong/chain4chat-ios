//
//  AvatarView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 14/11/23.
//

import SwiftUI

struct AvatarView: View {
    
    let urlString: String
    let size: CGFloat
    let topPadding: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { imageView in
            imageView
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
                .padding(.top, topPadding)
            
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundColor(.gray)
                .clipShape(Circle())
        }
    }
}

#Preview {
    AvatarView(urlString: "", size: 100, topPadding: 64)
}
