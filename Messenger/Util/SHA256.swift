//
//  SHA256.swift
//  LMessenger
//
//

import Foundation
import CryptoKit

// MARK: - String을 sha 암호화하는 메서드
func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()
    
    return hashString
}
