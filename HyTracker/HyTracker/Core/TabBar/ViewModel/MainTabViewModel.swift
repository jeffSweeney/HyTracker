//
//  MainTabViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import Combine
import Foundation

class MainTabViewModel: ObservableObject {
    @Published var user: User
    
    @Published var reportStartDate: Date
    @Published var reportEndDate: Date
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: User) {
        self.user = user
        self.reportStartDate = user.startDate ?? Date.now
        self.reportEndDate = Date.now
        
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser
            .compactMap{ $0 } // Don't accept nil to pass through
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - Track Days Functions
extension MainTabViewModel {
    var analyticsStartDate: Date {
        user.startDate ?? Date.now // Onboarding required - should never be nil
    }
    
    var reportStartRange: ClosedRange<Date> {
        analyticsStartDate ... reportEndDate
    }
    
    var reportEndRange: ClosedRange<Date> {
        reportStartDate ... Date.now
    }
    
    // TODO: Add back when we're ready to use
//    var weeklyRequirementTotal: Int {
//        user.weeklyRequirementTotal ?? 0 // Onboarding required - should never be nil
//    }
//    
//    var eligibleDaysSorted: String {
//        user.eligibleDays?.asSortedHyTrackerString ?? "" // Onboarding required - should never be nil
//    }
//    
//    var targetPercentage: String {
//        guard weeklyRequirementTotal != 0, let eligibleDays = user.eligibleDays, eligibleDays.count != 0, eligibleDays.count >= weeklyRequirementTotal else {
//            return "ERROR" // Shouldn't be reachable. Something has gone wrong. Probably throw?
//        }
//        
//        let result = round(Double(weeklyRequirementTotal)/Double(eligibleDays.count)*100)
//        return "\(String(format: "%.0f", result))%"
//    }
}

// MARK: - Generate Report Functions
extension MainTabViewModel {
    
}

// MARK: - Profile Functions
extension MainTabViewModel {
    
}
