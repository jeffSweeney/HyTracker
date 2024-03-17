//
//  ForgotPasswordSheet.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/17/24.
//

import SwiftUI

struct ForgotPasswordSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var email: String = ""
    
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
            
            AuthenticationTFComponent(component: .email, captureInput: $email)
                .padding(.horizontal)
            
            Button(action: {
                dismiss()
            }, label: {
                HTPrimaryButton(screen: .done, isActionable: true)
                    .padding(.vertical)
            })
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .modifier(HyTrackerGradient())
    }
}

#Preview {
    ForgotPasswordSheet()
}
