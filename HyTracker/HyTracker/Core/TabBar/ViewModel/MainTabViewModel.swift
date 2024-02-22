//
//  MainTabViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import Combine

class MainTabViewModel: ObservableObject {
    @Published var user: User
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: User) {
        self.user = user
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser
            .compactMap{ $0 } // Don't accept nil to pass through
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
    }
}
