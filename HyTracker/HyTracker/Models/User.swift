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
    var inOfficeDays: Set<Date>? // Actual days in office
    var exemptDays: Set<Date>? // PTO, Sick, etc
    
    init(id: String, 
         email: String,
         fullname: String,
         hasOnboarded: Bool,
         profileImageURL: String? = nil,
         startDate: Date? = nil,
         eligibleDays: Set<Weekday>? = nil,
         weeklyRequirementTotal: Int? = nil,
         inOfficeDays: Set<Date>? = nil,
         exemptDays: Set<Date>? = nil
    ) {
        self.id = id
        self.email = email
        self.fullname = fullname
        self.hasOnboarded = hasOnboarded
        self.profileImageURL = profileImageURL
        self.startDate = startDate
        self.eligibleDays = eligibleDays
        self.weeklyRequirementTotal = weeklyRequirementTotal
        self.inOfficeDays = inOfficeDays
        self.exemptDays = exemptDays
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
        
        if let inOfficeDaysArray = try container.decodeIfPresent([Date].self, forKey: .inOfficeDays) {
            inOfficeDays = Set(inOfficeDaysArray)
        } else {
            inOfficeDays = nil
        }
        
        if let exemptDaysArray = try container.decodeIfPresent([Date].self, forKey: .exemptDays) {
            exemptDays = Set(exemptDaysArray)
        } else {
            exemptDays = nil
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
        
        let inOfficeDaysArray = inOfficeDays?.map { $0 }
        try container.encodeIfPresent(inOfficeDaysArray, forKey: .inOfficeDays)
        
        let exemptDaysArray = exemptDays?.map { $0 }
        try container.encodeIfPresent(exemptDaysArray, forKey: .exemptDays)
    }
}

// MARK: - Firebase collection
extension User {
    static let collectionName = "users"
}
