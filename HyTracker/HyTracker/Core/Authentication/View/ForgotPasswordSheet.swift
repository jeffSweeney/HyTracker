//
//  ForgotPasswordSheet.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/17/24.
//

import SwiftUI

struct ForgotPasswordSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            Text("UNDER CONSTRUCTION")
                .font(.title)
                .underline()
            
            Text("Forgot Password Sheet")
                .font(.title3)
            
            Button(action: {
                dismiss()
            }, label: {
                HTPrimaryButton(screen: .done, isActionable: true)
            })
        }
        .navigationTitle("Forgot Password?")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ForgotPasswordSheet()
}
