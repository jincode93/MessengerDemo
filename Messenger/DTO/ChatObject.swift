//
//  ChatObject.swift
//  Messenger
//
//  Created by Zerom on 2024/01/04.
//

import Foundation

struct ChatObject: Codable {
    var chatId: String
    var userId: String
    var message: String?
    var photoURL: String?
    var date: TimeInterval
}

extension ChatObject {
    func toModel() -> Chat {
        .init(chatId: chatId,
              userId: userId,
              message: message,
              photoURL: photoURL,
              date: Date(timeIntervalSince1970: date))
    }
}
