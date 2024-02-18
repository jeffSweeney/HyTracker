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
    
    func signupTapped() {
        print("DEBUG: SIGN UP TAPPED")
    }
}
