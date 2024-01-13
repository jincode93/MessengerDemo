//
//  OtherProfileViewModel.swift
//  Messenger
//
//  Created by Zerom on 2024/01/04.
//

import SwiftUI
import PhotosUI

@MainActor
class OtherProfileViewModel: ObservableObject {
    
    @Published var userInfo: User?
    
    private let userId: String
    private var container: DIContainer
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userId: userId) {
            userInfo = user
        }
    }
    
}
