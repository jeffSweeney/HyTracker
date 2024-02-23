//
//  User+MockData.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import Foundation

extension User {
    static let BASIC_MOCK_USER = User(id: UUID().uuidString, email: "Jeff@test.com", fullname: "Jeff Sweeney", hasOnboarded: true)
    
    static let PROFILE_MOCK_USER = User(id: UUID().uuidString,
                                        email: "Jeff@test.com",
                                        fullname: "Jeff Sweeney",
                                        hasOnboarded: true,
                                        startDate: Date(),
                                        eligibleDays: [.monday, .tuesday, .wednesday, .thursday, .friday],
                                        weeklyRequirementTotal: 2
    )
}
