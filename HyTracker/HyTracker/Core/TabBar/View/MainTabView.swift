//
//  MainTabView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
            
            Text("UNDER CONSTRUCTION: Main Tab View")
                .padding(.vertical)
            Text("WELCOME, \(user.fullname)")
            Text("Email: \(user.email)")
            Text("Has Onboarded: \(user.hasOnboarded.description)")
            Text("Weekly Requirements: \(user.weeklyRequirementTotal?.description ?? "UNKNOWN")")
            
            Button(action: {
                AuthService.shared.signOut()
            }, label: {
                Text("SIGN OUT")
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
    }
}

#Preview {
    MainTabView(user: User(id: "id123",
                           email: "Jeff@test.com",
                           fullname: "Jeff Sweeney",
                           hasOnboarded: true))
}
