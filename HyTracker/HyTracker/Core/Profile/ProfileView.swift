//
//  ProfileView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct ProfileView: View {
    @State var user: User
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 24) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(Color.hyTrackerBlue)
                    
                    Text(user.fullname)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 40)
                
                HStack(alignment: .top) {
                    RequirementStack(user: user, requirement: .startDate)
                    
                    Divider()
                    
                    RequirementStack(user: user, requirement: .eligibleDays)
                    
                    Divider()
                    
                    RequirementStack(user: user, requirement: .totalDays)
                }
                .fixedSize(horizontal: true, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    print("DEBUG: Tapped EDIT REQUIREMENTS")
                }, label: {
                    HTPrimaryButton(screen: .profile, isActionable: true)
                })
                .padding(.top, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(HyTrackerGradient())
            .navigationTitle("PROFILE")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            AuthService.shared.signOut()
                        }
                    } label: {
                        Text("SIGN OUT")
                            .font(.footnote)
                            .foregroundStyle(.black)
                    }

                }
            }
            .fontDesign(.serif)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(user: User.PROFILE_MOCK_USER)
    }
}
