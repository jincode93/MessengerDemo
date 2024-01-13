//
//  ChatListViewModel.swift
//  Messenger
//
//  Created by Zerom on 2024/01/04.
//

import Combine
import Foundation

class ChatListViewModel: ObservableObject {
    
    enum Action {
        case load
    }
    
    @Published var chatRooms: [ChatRoom] = []
    
    var userId: String
    var container: DIContainer
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            container.services.chatRoomService.loadChatRooms(myUserId: userId)
                .sink { completion in
                } receiveValue: { [weak self] chatRooms in
                    self?.chatRooms = chatRooms
                }.store(in: &subscriptions)

        }
    }
}
