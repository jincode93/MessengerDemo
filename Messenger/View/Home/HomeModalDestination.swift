//
//  HomeModalDestination.swift
//  Messenger
//
//  Created by Zerom on 2024/01/01.
//

import Foundation

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    case setting
    
    var id: Int {
        hashValue
    }
}
