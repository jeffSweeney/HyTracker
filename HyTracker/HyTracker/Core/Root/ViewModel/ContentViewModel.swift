//
//  ContentViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/18/24.
//

import Combine
import Firebase

class ContentViewModel: ObservableObject {
    /// Sinks to changes in the Firebase User in the AuthService
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var showingLaunchScreen = true
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] user in
            self?.userSession = user
        }
        .store(in: &cancellables)
        
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }
        .store(in: &cancellables)
    }
}
