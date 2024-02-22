//
//  User+MockData.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import Foundation

extension User {
    static let MOCK_USER = User(id: UUID().uuidString, email: "Jeff@test.com", fullname: "Jeff Sweeney", hasOnboarded: true)
}
