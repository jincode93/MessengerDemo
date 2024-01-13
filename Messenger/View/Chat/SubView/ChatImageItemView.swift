//
//  ChatImageItemView.swift
//  Messenger
//
//  Created by Zerom on 2024/01/04.
//

import SwiftUI

struct ChatImageItemView: View {
    let urlString: String
    let direction: ChatItemDirection
    
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            
            URLImageView(urlString: urlString)
                .frame(width: 146, height: 146)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if direction == .left {
                Spacer()
            }
        }
        .padding(.horizontal, 35)
    }
}

struct ChatImageItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChatImageItemView(urlString: "", direction: .right)
    }
}
