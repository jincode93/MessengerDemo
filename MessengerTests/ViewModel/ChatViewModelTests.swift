//
//  ChatViewModelTests.swift
//  MessengerTests
//
//  Created by Zerom on 2024/01/08.
//

import Combine
import XCTest
@testable import Messenger

extension Date {
    init?(year: Int, month: Int, day: Int) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        guard let date = Calendar.current.date(from: components) else {
            return nil
        }
        
        self = date
    }
}

final class ChatViewModelTests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        subscriptions = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_addChat_equal_data() {
        
        let viewModel: ChatViewModel = .init(container: .stub, chatRoomId: "chatRoom1_id", myUserId: "user1_id", otherUserId: "user2_id")
        
        let date = Date(year: 2023, month: 11, day: 1)!
        
        viewModel.updateChatDataList(.init(chatId: "chat1_id", userId: "user1_id", date: date))
        viewModel.updateChatDataList(.init(chatId: "chat2_id", userId: "user1_id", date: date))
        viewModel.updateChatDataList(.init(chatId: "chat3_id", userId: "user1_id", date: date))
        viewModel.updateChatDataList(.init(chatId: "chat4_id", userId: "user1_id", date: date))
        
        XCTAssertEqual(viewModel.chatDataList.count, 1)
        XCTAssertEqual(viewModel.chatDataList[0].chats.count, 4)
    }
    
    func test_addChat_not_equal_date() {
        let viewModel: ChatViewModel = .init(container: .stub, chatRoomId: "chatRoom1_id", myUserId: "user1_id", otherUserId: "user2_id")
        
        var date = Date(year: 2023, month: 11, day: 1)!
        
        viewModel.updateChatDataList(.init(chatId: "chat1_id", userId: "user1_id", date: date))
        viewModel.updateChatDataList(.init(chatId: "chat2_id", userId: "user1_id", date: date))
        date = date.addingTimeInterval(24 * 60 * 60)
        viewModel.updateChatDataList(.init(chatId: "chat3_id", userId: "user1_id", date: date))
        date = date.addingTimeInterval(24 * 60 * 60)
        viewModel.updateChatDataList(.init(chatId: "chat4_id", userId: "user1_id", date: date))
        
        XCTAssertEqual(viewModel.chatDataList.count, 3)
        XCTAssertEqual(viewModel.chatDataList[0].chats.count, 2)
        XCTAssertEqual(viewModel.chatDataList[1].chats.count, 1)
        XCTAssertEqual(viewModel.chatDataList[2].chats.count, 1)
    }
}
