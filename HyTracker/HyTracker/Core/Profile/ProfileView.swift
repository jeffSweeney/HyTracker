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
                    VStack(spacing: 18) {
                        Text("Analytics Start Date")
                            .lineLimit(2)
                        
                        Text(user.startDate?.asHyTrackerDate ?? "UNKNOWN")
                            .fontWeight(.semibold)
                    }
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .frame(width: 100)
                    
                    Divider()
                        .foregroundStyle(Color.hyTrackerBlue)
                    
                    VStack(spacing: 18) {
                        Text("Eligible Office Days")
                            .lineLimit(2)
                        
                        Text(user.eligibleDays?.asSortedHyTrackerString ?? "UNKNOWN")
                            .fontWeight(.semibold)
                    }
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .frame(width: 100)
                    
                    Divider()
                    
                    VStack(spacing: 18) {
                        Text("Weekly Requirements")
                            .lineLimit(2)
                        
                        Text("\(weeklyRequirementString)")
                            .fontWeight(.semibold)
                    }
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .frame(width: 100)
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
                        AuthService.shared.signOut()
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
        ProfileView(viewModel: MainTabViewModel(user: User.PROFILE_MOCK_USER))
    }
}

extension ProfileView {
    var weeklyRequirementString: String {
        guard let totalRequirements = user.weeklyRequirementTotal else {
            return "UNKNOWN"
        }
        
        let suffix = totalRequirements > 1 ? "days" : "day"
        return "\(totalRequirements) \(suffix)"
    }
}
