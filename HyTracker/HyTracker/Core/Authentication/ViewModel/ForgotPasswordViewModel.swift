//
//  ForgotPasswordViewModel.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/18/24.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = "" { didSet { isValidEmail(email) } }
    @Published var isValidEmail: Bool = false
    @Published var isLoading: Bool = false
    @Published var showingAlert: Bool = false
    
    static let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    static let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    
    var alert: ResetPasswordAlert = .generic
    
    func isValidEmail(_ email: String) {
        isValidEmail = Self.emailTest.evaluate(with: email)
    }
    
    @MainActor
    func resetPasswordRequest() async {
        do {
            isLoading = true
            try await AuthService.shared.resetPassword(for: email)
            alert = .success
        } catch {
            alert = .failure
        }
        
        isLoading = false
        showingAlert = true
    }
}

enum ResetPasswordAlert {
    case success
    case failure
    
    case generic
    
    var title: String {
        switch self {
        case .success:
            "Success!"
        case .failure:
            "Error!"
        case .generic:
            "Alert!"
        }
    }
    
    var message: String {
        switch self {
        case .success: 
            "Reset instructions have been sent to your email. Reset your password and try again."
        case .failure: 
            "Unabled to send reset instruction email. Please check your provided email and try again."
        case .generic:
            "Unknown issue occurred. If you did not receive an email, please check your email address and try again."
        }
    }
}
