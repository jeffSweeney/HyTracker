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
    @Published var showingAlert: Bool = false
    var alertMessage: String = ""
    
    private func completedField() {
        loginFormComplete = !email.isEmpty && !password.isEmpty
    }
    
    @MainActor
    func loginTapped() async throws {
        isLoading = true
        do {
            try await AuthService.shared.signIn(withEmail: email, password: password)
        } catch {
            let message: String
            
            switch error {
            case AuthServiceError.invalidCredentials:
                message = "Invalid credentials provided."
            case AuthServiceError.invalidEmailFormat:
                message = "Invalid email format provided."
            default:
                message = "Encoutered errors loggin in. Please try again."
            }
            
            alertMessage = message
            isLoading = false
            showingAlert = true
        }
    }
    
    func clearAlert() {
        email = ""
        password = ""
        showingAlert = false
        alertMessage = ""
    }
}
