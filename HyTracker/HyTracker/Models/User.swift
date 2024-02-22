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
    
    init(id: String, 
         email: String,
         fullname: String,
         hasOnboarded: Bool,
         profileImageURL: String? = nil,
         startDate: Date? = nil,
         eligibleDays: Set<Weekday>? = nil,
         weeklyRequirementTotal: Int? = nil,
         exemptDays: Set<Date>? = nil,
         inOfficeDays: Set<Date>? = nil
    ) {
        self.id = id
        self.email = email
        self.fullname = fullname
        self.hasOnboarded = hasOnboarded
        self.profileImageURL = profileImageURL
        self.startDate = startDate
        self.eligibleDays = eligibleDays
        self.weeklyRequirementTotal = weeklyRequirementTotal
        self.exemptDays = exemptDays
        self.inOfficeDays = inOfficeDays
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullname
        case hasOnboarded
        case profileImageURL
        case startDate
        case eligibleDays
        case weeklyRequirementTotal
        case exemptDays
        case inOfficeDays
    }
}

// MARK: - Decoding
extension User {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Required properties
        id = try container.decode(String.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        fullname = try container.decode(String.self, forKey: .fullname)
        hasOnboarded = try container.decode(Bool.self, forKey: .hasOnboarded)
        
        // Basic optional properties
        profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL)
        startDate = try container.decodeIfPresent(Date.self, forKey: .startDate)
        weeklyRequirementTotal = try container.decodeIfPresent(Int.self, forKey: .weeklyRequirementTotal)
        
        // Conversion optional properties
        if let eligibleDaysArray = try container.decodeIfPresent([Int].self, forKey: .eligibleDays) {
            eligibleDays = Set(eligibleDaysArray.compactMap { Weekday(rawValue: $0) })
        } else {
            eligibleDays = nil
        }
        
        if let exemptDaysArray = try container.decodeIfPresent([Date].self, forKey: .exemptDays) {
            exemptDays = Set(exemptDaysArray)
        } else {
            exemptDays = nil
        }
        
        if let inOfficeDaysArray = try container.decodeIfPresent([Date].self, forKey: .inOfficeDays) {
            inOfficeDays = Set(inOfficeDaysArray)
        } else {
            inOfficeDays = nil
        }
    }
}

// MARK: - Encoding
extension User {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Required properties
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(fullname, forKey: .fullname)
        try container.encode(hasOnboarded, forKey: .hasOnboarded)
        
        // Basic optional properties
        try container.encodeIfPresent(profileImageURL, forKey: .profileImageURL)
        try container.encodeIfPresent(startDate, forKey: .startDate)
        try container.encodeIfPresent(weeklyRequirementTotal, forKey: .weeklyRequirementTotal)
        
        // Conversion optional properties
        let eligibleDaysArray = eligibleDays?.map { $0.rawValue }
        try container.encodeIfPresent(eligibleDaysArray, forKey: .eligibleDays)
        
        let exemptDaysArray = exemptDays?.map { $0 }
        try container.encodeIfPresent(exemptDaysArray, forKey: .exemptDays)

        let inOfficeDaysArray = inOfficeDays?.map { $0 }
        try container.encodeIfPresent(inOfficeDaysArray, forKey: .inOfficeDays)
    }
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
