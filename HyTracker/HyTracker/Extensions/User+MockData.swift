//
//  User+MockData.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import Foundation

extension User {
    fileprivate static var today: Date { return Date.today }
    fileprivate static var oneMonthAgo: Date { Calendar.current.date(byAdding: .month, value: -1, to: today)! }
    
    static let BASIC_MOCK_USER = User(id: UUID().uuidString, email: "Jeff@test.com", fullname: "Jeff Sweeney", hasOnboarded: true)
    
    static let PROFILE_MOCK_USER = User(id: UUID().uuidString,
                                        email: "Jeff@test.com",
                                        fullname: "Jeff Sweeney",
                                        hasOnboarded: true,
                                        startDate: Self.today,
                                        eligibleDays: [.monday, .tuesday, .wednesday, .thursday, .friday],
                                        weeklyRequirementTotal: 2
    )
    
    static let REPORT_MOCK_USER = User(id: UUID().uuidString,
                                       email: "Jeff@test.com",
                                       fullname: "Jeff Sweeney",
                                       hasOnboarded: true,
                                       startDate: Self.oneMonthAgo,
                                       eligibleDays: [.tuesday, .wednesday, .thursday],
                                       weeklyRequirementTotal: 2)
    
    static let TRACK_MOCK_USER = User(id: UUID().uuidString,
                                      email: "Jeff@test.com",
                                      fullname: "Jeff Sweeney",
                                      hasOnboarded: true,
                                      startDate: Self.oneMonthAgo,
                                      eligibleDays: [.tuesday, .wednesday, .thursday],
                                      weeklyRequirementTotal: 2,
                                      inOfficeDays: Self.evenDaysAgo(),
                                      exemptDays: Self.evenDaysAgo())
    
    private static func evenDaysAgo() -> Set<Date> {
        let evenDays = (2...30).filter { $0 % 2 == 0 }
        
        return evenDays.reduce(into: Set<Date>()) { (result: inout Set<Date>, daysAgo) in
            let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
            result.insert(date)
        }
    }
}
