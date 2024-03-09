//
//  TrackDaysViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/9/24.
//

import Combine
import Foundation

class TrackDaysViewModel: ObservableObject {
    // MARK: - Publishers
    @Published var user: User
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: User) {
        self.user = user
        
        setupSubscribers()
    }
    
    // MARK: Subscribers
    private func setupSubscribers() {
        UserService.shared.$currentUser
            .compactMap { $0 } // Do not allow nil sets
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
    }
}
