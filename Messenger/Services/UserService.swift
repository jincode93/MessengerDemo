//
//  UserService.swift
//  Messenger
//
//  Created by Zerom on 2024/01/01.
//

import Combine
import Foundation

protocol UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError>
    func addUserAterContact(users: [User]) -> AnyPublisher<Void, ServiceError>
    func getUser(userId: String) -> AnyPublisher<User, ServiceError>
    func getUser(userId: String) async throws -> User
    func updateFCMToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError>
    func updateDescription(userId: String, description: String) async throws
    func updateProfileURL(userId: String, urlString: String) async throws
    func loadUsers(id: String) -> AnyPublisher<[User], ServiceError>
    func filterUsers(with queryString: String, userId: String) -> AnyPublisher<[User], ServiceError>
}

class UserService: UserServiceType {
    
    private var dbRepository: UserDBRepositoryType
    
    init(dbRepository: UserDBRepositoryType) {
        self.dbRepository = dbRepository
    }
    
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        dbRepository.addUser(user.toObject())
            .map { user }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func addUserAterContact(users: [User]) -> AnyPublisher<Void, ServiceError> {
        dbRepository.addUserAfterContact(users: users.map { $0.toObject() })
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        dbRepository.getUser(userId: userId)
            .map { $0.toModel() }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) async throws -> User {
        let userObject = try await dbRepository.getUser(userId: userId)
        return userObject.toModel()
    }
    
    func updateFCMToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError> {
        dbRepository.updateUser(userId: userId, key: "fcmToken", value: fcmToken)
            .mapError { ServiceError.error($0) }
            .eraseToAnyPublisher()
    }
    
    func updateDescription(userId: String, description: String) async throws {
        try await dbRepository.updateUser(userId: userId, key: "description", value: description)
    }
    
    func updateProfileURL(userId: String, urlString: String) async throws {
        try await dbRepository.updateUser(userId: userId, key: "profileURL", value: urlString)
    }
    
    func loadUsers(id: String) -> AnyPublisher<[User], ServiceError> {
        dbRepository.loadUsers()
            .map { $0
                .map { $0.toModel() }
                .filter { $0.id != id }
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func filterUsers(with queryString: String, userId: String) -> AnyPublisher<[User], ServiceError> {
        dbRepository.filterUsers(with: queryString)
            .map { $0
                .map { $0.toModel() }
                .filter { $0.id != userId }
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
}

class StubUserService: UserServiceType {
    
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func addUserAterContact(users: [User]) -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<User, ServiceError> {
        Just(.stub1).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func getUser(userId: String) async throws -> User {
        return .stub1
    }
    
    func updateFCMToken(userId: String, fcmToken: String) -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func updateDescription(userId: String, description: String) async throws {
        
    }
    
    func updateProfileURL(userId: String, urlString: String) async throws {
        
    }
    
    func loadUsers(id: String) -> AnyPublisher<[User], ServiceError> {
        Just([.stub1, .stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func filterUsers(with queryString: String, userId: String) -> AnyPublisher<[User], ServiceError> {
        Just([.stub1, .stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
}
