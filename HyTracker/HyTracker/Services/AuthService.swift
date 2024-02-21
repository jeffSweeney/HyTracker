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
    
    @MainActor
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            try await UserService.shared.fetchCurrentUser()
            self.userSession = result.user
        } catch {
            // TODO: Properly handle/delegate error message
            print("DEBUG: Sign in error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await UserService.shared.createUser(uid: result.user.uid, withEmail: email, fullname: fullname)
            self.userSession = result.user
        } catch {
            print("DEBUG: Create user error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.signOut()
    }
}
