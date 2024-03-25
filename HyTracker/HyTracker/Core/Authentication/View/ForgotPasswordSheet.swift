//
//  ForgotPasswordSheet.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/17/24.
//

import SwiftUI

struct ForgotPasswordSheet: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
                
                Spacer()
            }
            .padding()
            
            HTLogoView(size: .small)
            
            Text("Enter your registered email below to receive password reset instruction")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom)
            
            AuthenticationTFComponent(component: .email, captureInput: $viewModel.email)
                .padding(.horizontal)
            
            Button(action: {
                Task { await viewModel.resetPasswordRequest() }
            }, label: {
                HTButton(context: .resetPassword,
                                isActionable: viewModel.isValidEmail,
                                isLoading: $viewModel.isLoading)
                .padding(.vertical)
            })
            .disabled(!viewModel.isValidEmail)
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .modifier(HyTrackerGradient())
        .alert(viewModel.alert.title, isPresented: $viewModel.showingAlert) {
            Button("Got it!") {
                viewModel.showingAlert = false
                
                switch viewModel.alert {
                case .success:
                    dismiss()
                case .failure, .generic:
                    viewModel.alert = .generic
                }
            }
        } message: {
            Text(viewModel.alert.message)
                .font(.subheadline)
        }
        
    }
}

#Preview {
    ForgotPasswordSheet()
}
