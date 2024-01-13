//
//  URLImageViewModel.swift
//  Messenger
//
//  Created by Zerom on 2024/01/03.
//

import Combine
import UIKit

class URLImageViewModel: ObservableObject {
    
    var loadingOrSuccess: Bool {
        return isLoading || loadingImage != nil
    }
    
    @Published var loadingImage: UIImage?
    
    private var isLoading: Bool = false
    private var urlString: String
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, urlString: String) {
        self.container = container
        self.urlString = urlString
    }
    
    func start() {
        guard !urlString.isEmpty else { return }
        
        isLoading = true
        
        container.services.imageCacheService.image(for: urlString)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.isLoading = false
                self?.loadingImage = image
            }.store(in: &subscriptions)
    }
}
