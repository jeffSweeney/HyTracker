//
//  LoginViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = "" { didSet { completedField() } }
    @Published var password: String = "" { didSet { completedField() } }
    
    @Published var loginFormComplete: Bool = false
    @Published var isLoading: Bool = false
    
    private func completedField() {
        loginFormComplete = !email.isEmpty && !password.isEmpty
    }
    
    @MainActor
    func loginTapped() async throws {
        isLoading = true
        try await AuthService.shared.signIn(withEmail: email, password: password)
    }
}
