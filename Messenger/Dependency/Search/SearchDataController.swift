//
//  SearchDataController.swift
//  Messenger
//
//  Created by Zerom on 2024/01/05.
//

import CoreData
import Foundation

protocol DataControllable {
    var persistantContainer: NSPersistentContainer { get set }
}

class SearchDataController: DataControllable {
    
    var persistantContainer = NSPersistentContainer(name: "Search")
    
    init() {
        persistantContainer.loadPersistentStores { description, error in
            if let error {
                print("Core data failed: ", error)
            }
        }
    }
}
