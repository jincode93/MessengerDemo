//
//  PushObject.swift
//  Messenger
//
//  Created by Zerom on 2024/01/05.
//

import Foundation

struct PushObject: Encodable {
    var to: String
    var notification: NotificationObject
    
    struct NotificationObject: Encodable {
        var title: String
        var body: String
    }
}
