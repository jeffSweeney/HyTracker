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
    var requiredDays: Int?
}

// MARK: - Firebase collection
extension User {
    static let collectionName = "users"
}
