//
//  AuthService.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/18/24.
//

import Foundation
import Firebase

final class AuthService {
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
    // Keep private - only supporting singleton
    private init() {
        userSession = Auth.auth().currentUser
    }
    
    func signIn() {
        print("DEBUG: Auth Service signIn called")
    }
    
    func createUser() {
        print("DEBUG: Auth Service createUser called")
    }
}
