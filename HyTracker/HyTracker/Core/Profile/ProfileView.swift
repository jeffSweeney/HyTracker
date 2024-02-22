//
//  ProfileView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: MainTabViewModel
    
    var user: User { return viewModel.user }
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
                .padding(.vertical)
            
            VStack(spacing: 8) {
                Text("ProfileView")
                Text("UNDER CONSTRUCTION")
            }
            .padding(.vertical)
            
            Text("Welcome, \(user.fullname)!")
            
            VStack(spacing: 4) {
                Text("Current Data")
                    .underline()
                
                Text("Email: \(user.email)")
                Text("Has Onboarded: \(user.hasOnboarded.description)")
                Text("Start date: \(user.startDate?.asHyTrackerDate ?? "UNKNOWN")")
                Text("Workdays: \(user.eligibleDays?.sorted{$0.rawValue < $1.rawValue}.map{$0.label}.joined(separator: ", ") ?? "UNKNOWN")")
                Text("Weekly Requirements: \(user.weeklyRequirementTotal?.description ?? "UNKNOWN")")
            }
            .padding(.vertical)
            
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
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
    }
}

#Preview {
    ProfileView(viewModel: MainTabViewModel(user: User.MOCK_USER))
}
