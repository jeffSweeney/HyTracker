//
//  OnboardingViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    // MARK: - Top level state properties
    @Published var startDate: Date? = nil { didSet { updatedAnswer() } }
    @Published var eligibleWorkdays: Set<Weekday> = [] { didSet { updatedAnswer() } }
    @Published var requiredDays: Int? = nil { didSet { updatedAnswer() } }
    
    // MARK: - Temp level state properties - used during input stage
    @Published var bindingDate: Date = .now
    @Published var bindingCount: Int = 0
    
    // MARK: - Button Eligibilities
    @Published var answeredStartDate: Bool = false
    @Published var answeredEligibleWorkdays: Bool = false
    @Published var answeredRequirementDays: Bool = false
    @Published var answeredAllOnboarding: Bool = false
    
    private func updatedAnswer() {
        answeredStartDate = startDate != nil
        answeredEligibleWorkdays = !eligibleWorkdays.isEmpty
        answeredRequirementDays = (requiredDays ?? 0) > 0
        
        answeredAllOnboarding = answeredStartDate
                                && answeredEligibleWorkdays
                                && answeredRequirementDays
    }
    
    // MARK: - Sheet Dismissal Processing
    func processDateSelectorSheet() {
        if bindingDate > Date.now { // Indicates Cancel was tapped - don't persist result
            bindingDate = startDate ?? .now // Set back to last selection if we have one
        } else { // valid selection made
            startDate = bindingDate
        }
    }
    
    func processEligibleWorkdaySheet() {
        // Unset the required days if the new eligibleWorkdays is less than the previous selection
        if bindingCount > eligibleWorkdays.count {
            bindingCount = 0
            requiredDays = nil
        }
    }
    
    func processRequirementSheet() {
        if bindingCount > 0 {
            requiredDays = bindingCount
        }
    }
}
