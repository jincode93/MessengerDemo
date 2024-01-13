//
//  PushNotificationProvider.swift
//  Messenger
//
//  Created by Zerom on 2024/01/05.
//

import Combine
import Foundation

protocol PushNotificationProviderType {
    func sendPushNotification(object: PushObject) -> AnyPublisher<Bool, Never>
}

class PushNotificationProvider: PushNotificationProviderType {
    
    private let serverURL: URL = URL(string: "https://fcm.googleapis.com/fcm/send")!
    private let serverKey: String = "AAAAiOE2JQc:APA91bHaI-_DFZCbiKTsKWMVRUkh22gsDaqdANq4EhQE5A1apXvlWHv7nQZGYuCa_XABpkfwjW9PiLnRoGHATwwYCGNGDY9SY-x-FQbpONhr1JgpxBsMcTDD8EXItftlB98GqkZTuGbV"
    
    func sendPushNotification(object: PushObject) -> AnyPublisher<Bool, Never> {
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(object)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in true }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
}
