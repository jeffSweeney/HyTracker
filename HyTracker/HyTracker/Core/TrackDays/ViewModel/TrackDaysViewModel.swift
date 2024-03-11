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
    @Published var madeBulkTrackUpdates: Bool
    @Published var showingAlert: Bool
    @Published var today: Date
    var alertMessage: String?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: User) {
        self.user = user
        self.madeBulkTrackUpdates = false // Initially no updates
        // Initially no alert
        self.showingAlert = false
        self.alertMessage = nil
        self.today = Date.today
        
        setupSubscribers()
    }
    
    // MARK: - Subscribers
    private func setupSubscribers() {
        UserService.shared.$currentUser
            .compactMap { $0 } // Do not allow nil sets
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Public Helpers
    
    var eligibleDaysSorted: String {
        user.eligibleDays?.asSortedHyTrackerString ?? "" // Onboarding required - should never be nil
    }
    
    // Range of dates to display for each bulk update scenario
    var inOfficeDatesRange: [SimpleDate] { bulkUpdateRange(endDate: today) }
    var exemptDatesRange: [SimpleDate] { bulkUpdateRange(endDate: Calendar.current.date(byAdding: .day, value: 7, to: today) ?? today) }
    
    var inOfficeDatesChecked: Set<SimpleDate> { Set(user.inOfficeDays?.map { $0.asSimpleDate } ?? []) }
    var exemptDatesChecked: Set<SimpleDate> { Set(user.exemptDays?.map { $0.asSimpleDate } ?? []) }
    
    /// `uploadToday`
    /// Will attempt to upload today as an in-office or exempt day. If it's not an eligible workday, or is already registered as in-office/exempt, operation wont be performed and the alert publisher will be triggered.
    @MainActor
    func uploadToday(as updateType: TrackUpdateType) async throws {
        // Today must be an eligible workday, otherwise do not continue.
        let eligibleDays = user.eligibleDays ?? []
        guard let weekday = today.asWeekday, eligibleDays.contains(weekday) else {
            alertMessage = "Today is not an eligible workday for analytics. Please update your profile requirements if they have changed."
            showingAlert = true
            return
        }
        
        // Today can't already be registered as in-office/exempt, otherwise do not continue.
        var contextSet = (updateType == .inOffice ? user.inOfficeDays : user.exemptDays) ?? []
        guard !contextSet.contains(today) else {
            alertMessage = "You've already registered today as '\(updateType.alertContext)'. If you wish to remove it, please do so in the Bulk Updates section."
            showingAlert = true
            return
        }
        
        // Safe to upload today
        var updatedUser = user
        contextSet.insert(today)
        switch updateType {
        case .exempt: updatedUser.exemptDays = contextSet
        case .inOffice: updatedUser.inOfficeDays = contextSet
        }
        try await UserService.shared.updateCurrentUser(with: updatedUser)
    }
    
    func uploadOfficeDays(days: Set<SimpleDate>) async throws {
        do {
            var updatedUser = user
            updatedUser.inOfficeDays = convertSimpleDateSet(with: days)
            
            try await UserService.shared.updateCurrentUser(with: updatedUser)
        } catch {
            print("DEBUG: Error updating user: \(error.localizedDescription)")
        }
    }
    
    func uploadExemptDays(days: Set<SimpleDate>) async throws {
        do {
            var updatedUser = user
            updatedUser.exemptDays = convertSimpleDateSet(with: days)
            
            try await UserService.shared.updateCurrentUser(with: updatedUser)
        } catch {
            print("DEBUG: Error updating user: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Private Helpers
    
    private func bulkUpdateRange(endDate: Date) -> [SimpleDate] {
        let eligibleDays = user.eligibleDays ?? []
        var currentDate = user.startDate ?? today
        
        let calendar = Calendar.current
        let components = DateComponents(day: 1)
        var result: Set<Date> = []
        
        while currentDate <= endDate {
            if let currentDay = currentDate.asWeekday, eligibleDays.contains(currentDay) {
                result.insert(currentDate)
            }
            
            if let nextDate = calendar.date(byAdding: components, to: currentDate) {
                currentDate = nextDate.startOfDay
            } else {
                break
            }
        }
        
        return result.sorted { $0 > $1 }.map { $0.asSimpleDate }
    }
    
    private func convertSimpleDateSet(with days: Set<SimpleDate>) -> Set<Date> {
        var result: [Date] = []
        for simpleDate in days {
            let date = simpleDate.asDate
            result.append(date)
        }
        
        return Set(result)
    }
}
