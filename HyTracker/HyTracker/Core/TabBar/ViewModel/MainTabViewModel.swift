//
//  MainTabViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/25/24.
//

import Foundation

class MainTabViewModel: ObservableObject {
    @Published var today: Date = .today
    
    // Singleton
    static var shared = MainTabViewModel()
    private init() { }
    
    /// `refreshToday` should be called from `MainTabView` when it detects the App being foreground. Downstream subscribers can sink to this change.
    func refreshToday() {
        today = .today
    }
}
