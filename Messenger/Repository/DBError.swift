//
//  DBError.swift
//  Messenger
//
//  Created by Zerom on 2024/01/01.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
