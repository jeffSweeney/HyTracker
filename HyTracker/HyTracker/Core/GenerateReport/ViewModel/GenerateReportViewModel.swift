//
//  GenerateReportViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/9/24.
//

import Combine
import Foundation

class GenerateReportViewModel: ObservableObject {
    // MARK: - Publishers
    @Published var user: User
    @Published var reportStartDate: Date
    @Published var reportEndDate: Date
    @Published var report: Report? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: User) {
        self.user = user
        self.reportStartDate = Self.defaultReportStartDate(for: user)
        self.reportEndDate = Date.today
        
        setupSubscribers()
    }
    
    // MARK: - Subscribers
    private func setupSubscribers() {
        UserService.shared.$currentUser
            .compactMap{ $0 } // Do not allow nil sets
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
        
        MainTabViewModel.shared.$today
            .map { $0 }
            .assign(to: \.reportEndDate, on: self)
            .store(in: &cancellables)
    }

    // MARK: - Helpers
    
    /// `defaultReportStartDate`
    /// Derives a manageable default report start date - 4 weeks (or less if analytics start date is more recent).
    /// If we simply use analytics start date as the default, over time, this will lead to a massive difference in report default start/end date.
    private static func defaultReportStartDate(for user: User) -> Date {
        let today = Date.today
        let fourWeeksAgo = Calendar.current.date(byAdding: .weekOfYear, value: -4, to: today)
        let earliestStartDate = user.startDate ?? today
        
        // Only able to set 4 weeks ago if earliestStartDate is older than 4 weeks ago.
        if let fourWeeksAgo, fourWeeksAgo > earliestStartDate {
            return fourWeeksAgo
        } else {
            return earliestStartDate
        }
    }
    
    var analyticsStartDate: Date {
        user.startDate ?? Date.today // Onboarding required - should never be nil
    }
    
    var reportStartRange: ClosedRange<Date> {
        analyticsStartDate ... reportEndDate
    }
    
    var reportEndRange: ClosedRange<Date> {
        reportStartDate ... Date.today
    }
    
    var weeklyRequirementTotal: Int {
        user.weeklyRequirementTotal ?? 0 // Onboarding required - should never be nil
    }
    
    var targetPercentage: String {
        guard weeklyRequirementTotal != 0, let eligibleDays = user.eligibleDays, eligibleDays.count != 0, eligibleDays.count >= weeklyRequirementTotal else {
            return "ERROR" // Shouldn't be reachable. Something has gone wrong. Probably throw?
        }
        
        let result = round(Double(weeklyRequirementTotal)/Double(eligibleDays.count)*100)
        return "\(String(format: "%.0f", result))%"
    }
    
    func runReport() {
        // Never nil or empty since onboarded. Unexpected edgecase will produce a "No eligible workdays in range" result for now.
        let eligibleDays = user.eligibleDays ?? []
        let officeDays = user.inOfficeDays ?? [] // Has data or assumes empty in calculation
        let exemptDays = user.exemptDays ?? [] // Has data or assumes empty in calculation
        
        // Accumulators for report
        var totalDaysInOffice = 0
        var eligibleDaysInOffice = 0
        
        // Opting for full iteration O(n) rather than multiple set operations
        let calendar = Calendar.current
        let components = DateComponents(day: 1)
        var currentDate = reportStartDate.startOfDay
        while currentDate <= reportEndDate.startOfDay {
            // To be considered in analytics, currentDate must:
            // - Be a weekday within the eligibleDays of the user AND
            // - NOT be marked as an exempt day
            if let weekday = currentDate.asWeekday, eligibleDays.contains(weekday), !exemptDays.contains(currentDate) {
                // Eligible day for analytics
                eligibleDaysInOffice += 1
                
                // Marked in office
                if officeDays.contains(currentDate) {
                    totalDaysInOffice += 1
                }
            }
            
            if let nextDate = calendar.date(byAdding: components, to: currentDate) {
                currentDate = nextDate
            } else {
                break
            }
        }
        
        report = Report(officeDays: totalDaysInOffice, totalDays: eligibleDaysInOffice)
    }
    
    var eligibleDaysSorted: String {
        user.eligibleDays?.asSortedHyTrackerString ?? "" // Onboarding required - should never be nil
    }
}
