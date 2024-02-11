//
//  AuthenticationTFComponent.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct AuthenticationTFComponent: View {
    enum Component {
        case email
        case password
        
        var label: String {
            switch self {
            case .email:
                "Email"
            case .password:
                "Password"
            }
        }
    }
    
    let component: Component
    var captureInput: Binding<String>
    
    @State private var showingPassword = false
    @FocusState private var inputFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if component == .password && !showingPassword {
                    SecureField(component.label, text: captureInput)
                        .textInputAutocapitalization(.never)
                        .padding(.bottom, 5)
                        .focused($inputFocused)
                } else {
                    TextField(component.label, text: captureInput)
                        .textInputAutocapitalization(.never)
                        .padding(.bottom, 5)
                        .focused($inputFocused)
                }
                
                Spacer()
                
                if !captureInput.wrappedValue.isEmpty && inputFocused {
                    Button(action: {
                        captureInput.wrappedValue = ""
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(.black)
                    })
                }
            }
            
            Rectangle()
                .frame(height: inputFocused ? 1.25 : 1)
                .foregroundColor(inputFocused ? .primary : .secondary)
            
            // Determine if we need the show/hide password button
            if component == .password {
                Button(action: {
                    showingPassword.toggle()
                }, label: {
                    Text(showingPassword ? "HIDE PASSWORD" : "SHOW PASSWORD")
                        .font(.caption)
                        .foregroundStyle(.black)
                })
            }
        }
    }
}

#Preview {
    AuthenticationTFComponent(component: .password, captureInput: .constant(""))
}
