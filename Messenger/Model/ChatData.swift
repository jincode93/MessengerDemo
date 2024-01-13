//
//  ChatData.swift
//  Messenger
//
//  Created by Zerom on 2024/01/04.
//

import Foundation

struct ChatData: Hashable, Identifiable {
    var dateStr: String
    var chats: [Chat]
    var id: String { dateStr }
}
