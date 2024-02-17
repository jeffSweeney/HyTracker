//
//  LoginView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
            
            VStack(spacing: 20) {
                AuthenticationTFComponent(component: .email, captureInput: $email)
                
                AuthenticationTFComponent(component: .password, captureInput: $password)
            }
            .padding()
            
            Button(action: {
                print("DEBUG: LOG IN TAPPED")
            }, label: {
                Text("LOG IN")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 40)
                    .overlay {
                        Capsule()
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.black)
                    }
                    .padding()
            })
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
