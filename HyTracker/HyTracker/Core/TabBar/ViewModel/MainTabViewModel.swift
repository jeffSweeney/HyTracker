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
    
    // MARK: - Track Days Properties
    @Published var madeBulkTrackUpdates = false
    
    // MARK: - Generate Report Properties
    @Published var reportStartDate: Date
    @Published var reportEndDate: Date
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: User) {
        self.user = user
        self.reportStartDate = Self.defaultReportStartDate(for: user)
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

// MARK: - Common Functions and Properties
extension MainTabViewModel {
    var eligibleDaysSorted: String {
        user.eligibleDays?.asSortedHyTrackerString ?? "" // Onboarding required - should never be nil
    }
}

// MARK: - Track Days Functions and Properties
extension MainTabViewModel {
    private func bulkUpdateRange(endDate: Date) -> [Date] {
        let eligibleDays = user.eligibleDays ?? []
        let today = Date.now
        var currentDate = user.startDate ?? today
        
        let calendar = Calendar.current
        let components = DateComponents(day: 1)
        var result: Set<Date> = []
        
        while currentDate <= endDate {
            if let currentDay = currentDate.asWeekday, eligibleDays.contains(currentDay) {
                result.insert(currentDate)
            }
            
            if let nextDate = calendar.date(byAdding: components, to: currentDate) {
                currentDate = nextDate
            } else {
                break
            }
        }
        
        return result.sorted { $0 > $1 }
    }
    
    var inOfficeRange: [Date] { bulkUpdateRange(endDate: Date.now) }
    var exemptRange: [Date] { bulkUpdateRange(endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date.now) ?? Date.now) }
    
    var inOfficeSimpleDates: Set<SimpleDate> { Set(user.inOfficeDays?.map { $0.asSimpleDate } ?? []) }
    var exemptSimpleDates: Set<SimpleDate> { Set(user.exemptDays?.map { $0.asSimpleDate } ?? []) }
    
    private func convertSimpleDateSet(with days: Set<SimpleDate>) throws -> Set<Date> {
        var result: [Date] = []
        for simpleDate in days {
            let date = try simpleDate.asDate()
            result.append(date)
        }
        
        return Set(result)
    }
    
    func uploadOfficeDays(days: Set<SimpleDate>) async throws {
        do {
            var updatedUser = user
            updatedUser.inOfficeDays = try convertSimpleDateSet(with: days)
            
            try await UserService.shared.updateCurrentUser(with: updatedUser)
        } catch {
            print("DEBUG: Error updating user: \(error.localizedDescription)")
        }
    }
    
    func uploadExemptDays(days: Set<SimpleDate>) async throws {
        do {
            var updatedUser = user
            updatedUser.exemptDays = try convertSimpleDateSet(with: days)
            
            try await UserService.shared.updateCurrentUser(with: updatedUser)
        } catch {
            print("DEBUG: Error updating user: \(error.localizedDescription)")
        }
    }
}

// MARK: - Generate Report Functions and Properties
extension MainTabViewModel {
    /// `defaultReportStartDate`
    /// Derives a manageable default report start date - 4 weeks (or less if analytics start date is more recent).
    /// If we simply use analytics start date as the default, over time, this will lead to a massive difference in report default start/end date.
    private static func defaultReportStartDate(for user: User) -> Date {
        let today = Date.now
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
        user.startDate ?? Date.now // Onboarding required - should never be nil
    }
    
    var reportStartRange: ClosedRange<Date> {
        analyticsStartDate ... reportEndDate
    }
    
    var reportEndRange: ClosedRange<Date> {
        reportStartDate ... Date.now
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
    
    var actualPercentage: String {
        // TODO: Calculate
        return "75%"
    }
}

// MARK: - Profile Functions and Properties
extension MainTabViewModel {
    
}
