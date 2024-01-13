//
//  Constant.swift
//  Messenger
//
//  Created by Zerom on 2024/01/01.
//

import Foundation

typealias DBKey = Constant.DBKey
typealias AppStorageType = Constant.AppStorage

enum Constant { }

extension Constant {
    struct DBKey {
        static let Users = "Users"
        static let ChatRooms = "ChatRooms"
        static let Chats = "Chats"
    }
}

extension Constant {
    struct AppStorage {
        static let Appearance = "AppStorage_Appearance"
    }
}
