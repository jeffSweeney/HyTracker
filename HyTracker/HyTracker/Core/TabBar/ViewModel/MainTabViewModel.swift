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
