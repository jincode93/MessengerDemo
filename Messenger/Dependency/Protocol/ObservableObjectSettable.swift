//
//  ObservableObjectSettable.swift
//  Messenger
//
//  Created by Zerom on 2024/01/07.
//

import Combine
import Foundation

protocol ObservableObjectSettable: AnyObject {
    var objectWillChange: ObservableObjectPublisher? { get set }
    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher)
}

extension ObservableObjectSettable {
    
    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher) {
        self.objectWillChange = objectWillChange
    }
}
