//
//  UploadSourceType.swift
//  Messenger
//
//  Created by Zerom on 2024/01/03.
//

import Foundation

enum UploadSourceType {
    case chat(chatRoomId: String)
    case profile(userId: String)
    
    var path: String {
        switch self {
        case let .chat(chatRoomId):
            return "\(DBKey.Chats)/\(chatRoomId)"
        case let .profile(userId):
            return "\(DBKey.Users)/\(userId)"
        }
    }
}
