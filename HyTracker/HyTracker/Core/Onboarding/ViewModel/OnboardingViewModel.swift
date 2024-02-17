//
//  OnboardingViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var startDate: Date? = nil
    @Published var eligibleWorkdays: Set<Weekday> = []
    @Published var requiredDays: Int? = nil
    
    // Determines if onboarding is able to be completed
    var canProceed: Bool {
        guard let daysCount = requiredDays else { return false }
        
        return startDate != nil && !eligibleWorkdays.isEmpty && daysCount > 0
    }
}
