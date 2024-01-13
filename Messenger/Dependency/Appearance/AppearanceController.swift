//
//  AppearanceController.swift
//  Messenger
//
//  Created by Zerom on 2024/01/06.
//

import Combine
import Foundation

protocol AppearanceControllerable {
    var appearance: AppearanceType { get set }
    
    func changeAppearance(_ willBeAppearance: AppearanceType?)
}

class AppearanceController: AppearanceControllerable, ObservableObjectSettable {
    
    var objectWillChange: ObservableObjectPublisher?
    
    var appearance: AppearanceType = .automatic {
        didSet {
            objectWillChange?.send()
        }
    }
    
    func changeAppearance(_ willBeAppearance: AppearanceType?) {
        appearance = willBeAppearance ?? .automatic
    }
}
