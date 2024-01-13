//
//  OtherProfileMenuType.swift
//  Messenger
//
//  Created by Zerom on 2024/01/04.
//

import Foundation

enum OtherProfileMenuType: Hashable, CaseIterable {
    case chat
    case phoneCell
    case videoCell
    
    var description: String {
        switch self {
        case .chat:
            return "대화"
        case .phoneCell:
            return "음성통화"
        case .videoCell:
            return "영상통화"
        }
    }
    
    var imageName: String {
        switch self {
        case .chat:
            return "sms"
        case .phoneCell:
            return "phone_profile"
        case .videoCell:
            return "videocam"
        }
    }
}
