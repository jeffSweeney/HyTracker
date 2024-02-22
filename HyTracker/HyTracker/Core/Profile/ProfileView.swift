//
//  ProfileView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
                .padding(.vertical)
            
            Text("ProfileView: UNDER CONSTRUCTION")
                .padding(.vertical)
            
            Text("Welcome, \(viewModel.user.fullname)!")
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
    }
}

#Preview {
    ProfileView(viewModel: MainTabViewModel(user: User.MOCK_USER))
}
