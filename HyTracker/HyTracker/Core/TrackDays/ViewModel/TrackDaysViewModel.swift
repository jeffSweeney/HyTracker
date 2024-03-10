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
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(user: User) {
        self.user = user
        self.madeBulkTrackUpdates = false // Initially no updates
        
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
    // TODO: Convert these to SimpleDate
    var inOfficeDatesRange: [SimpleDate] { bulkUpdateRange(endDate: Date.today) }
    var exemptDatesRange: [SimpleDate] { bulkUpdateRange(endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date.today) ?? Date.today) }
    
    var inOfficeDatesChecked: Set<SimpleDate> { Set(user.inOfficeDays?.map { $0.asSimpleDate } ?? []) }
    var exemptDatesChecked: Set<SimpleDate> { Set(user.exemptDays?.map { $0.asSimpleDate } ?? []) }
    
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
        let today = Date.today
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
