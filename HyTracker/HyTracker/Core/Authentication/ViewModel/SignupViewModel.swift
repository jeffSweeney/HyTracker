//
//  SignupViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var fullname: String = "" { didSet { completedField() } }
    @Published var email: String = "" { didSet { completedField() } }
    @Published var password: String = "" { didSet { completedField() } }
    
    @Published var signupFormComplete: Bool = false
    
    private func completedField() {
        signupFormComplete = !fullname.isEmpty && !email.isEmpty && !password.isEmpty
    }
    
    @MainActor
    func signupTapped() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
