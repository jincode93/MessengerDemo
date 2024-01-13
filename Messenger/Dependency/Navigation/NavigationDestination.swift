//
//  NavigationDestination.swift
//  Messenger
//
//  Created by Zerom on 2024/01/04.
//

import Foundation

enum NavigationDestination: Hashable {
    case chat(chatRoomId: String, myUserId: String, otherUserId: String)
    case search(userId: String)
}
