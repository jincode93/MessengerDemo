//
//  AuthenticationViewModel.swift
//  Messenger
//
//  Created by Zerom on 2023/12/30.
//

import AuthenticationServices
import Combine
import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case requestPushNotification
        case setPushToken
        case logout
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLoading = false
    
    var userId: String?
    
    private var currentNonce: String?
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
            
        // Login 상태 체크
        case .checkAuthenticationState:
            if let userId = container.services.authService.checkAuthenticationState() {
                self.userId = userId
                self.authenticationState = .authenticated
            }
            
        // google 로그인
        case .googleLogin:
            isLoading = true
            
            container.services.authService.signInWithGoogle()
                .flatMap { user in
                    self.container.services.userService.addUser(user)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userId = user.id
                    self?.authenticationState = .authenticated
                }.store(in: &subscriptions)
            
        // apple 로그인
        case let .appleLogin(request):
            isLoading = true
            
            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
            currentNonce = nonce
            
        // apple 로그인 Completion (apple 로그인은 자체적으로 Completion을 만들어주지 않음)
        case let .appleLoginCompletion(result):
            if case let .success(authorization) = result {
                guard let nonce = currentNonce else { return }
                
                container.services.authService.handleSignInWithAppleCompletion(authorization, none: nonce)
                    .flatMap { user in
                        self.container.services.userService.addUser(user)
                    }
                    .sink { [weak self] completion in
                        if case .failure = completion {
                            self?.isLoading = false
                        }
                    } receiveValue: { [weak self] user in
                        self?.isLoading = false
                        self?.userId = user.id
                        self?.authenticationState = .authenticated
                    }
                    .store(in: &subscriptions)
            } else if case let .failure(error) = result {
                isLoading = false
                print(error.localizedDescription)
            }
            
        case .requestPushNotification:
            container.services.pushNotificationService.requestAuthorization { [weak self] granted in
                guard granted else { return }
                self?.send(action: .setPushToken)
            }
            
        case .setPushToken:
            container.services.pushNotificationService.fcmToken
                .compactMap { $0 }
                .flatMap { fcmToken -> AnyPublisher<Void, Never> in
                    guard let userId = self.userId else { return Empty().eraseToAnyPublisher() }
                    return self.container.services.userService.updateFCMToken(userId: userId, fcmToken: fcmToken)
                        .replaceError(with: ())
                        .eraseToAnyPublisher()
                }
                .sink { _ in
                }.store(in: &subscriptions)
            
        // 로그아웃
        case .logout:
            container.services.authService.logout()
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userId = nil
                }
                .store(in: &subscriptions)
        }
    }
}
