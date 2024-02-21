//
//  User.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/18/24.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let email: String
    var fullname: String
    var hasOnboarded: Bool
    var profileImageURL: String?
    var startDate: Date?
    var eligibleDays: Set<Weekday>?
    var weeklyRequirementTotal: Int?
    var exemptDays: Set<Date>? // PTO, Sick, etc
    var inOfficeDays: Set<Date>? // Actual days in office
}

// MARK: - Firebase collection
extension User {
    static let collectionName = "users"
}

// MARK: - Mutable User Properties
enum MutableUserProperty {
    case fullname(String)
    case hasOnboarded(Bool)
    case profileImageURL(String)
    case startDate(Date)
    case eligibleDays(Set<Weekday>)
    case weeklyRequirementTotal(Int)
    case exemptDays(Set<Date>)
    case inOfficeDays(Set<Date>)
    
    var kvUpdate: (String, Any) {
        switch self {
        case .fullname(let value):
            return ("fullname", value)
        case .hasOnboarded(let value):
            return ("hasOnboarded", value)
        case .profileImageURL(let value):
            return ("profileImageURL", value)
        case .startDate(let value):
            return ("startDate", value)
        case .eligibleDays(let value):
            return ("eligibleDays", value)
        case .weeklyRequirementTotal(let value):
            return ("weeklyRequirementTotal", value)
        case .exemptDays(let value):
            return ("exemptDays", value)
        case .inOfficeDays(let value):
            return ("inOfficeDays", value)
        }
    }
}
