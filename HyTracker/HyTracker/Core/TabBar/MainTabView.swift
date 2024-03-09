//
//  MainTabView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var currentUser: User
    
    init(user: User) {
        _currentUser = State(wrappedValue: user)
    }
    
    var body: some View {
        TabView {
            TrackDaysView(user: currentUser)
                .tabItem {
                    Label("Track", systemImage: "calendar.badge.clock")
                }
            
            GenerateReportView(user: currentUser)
                .tabItem {
                    Label("Report", systemImage: "chart.xyaxis.line")
                }
            
            ProfileView(user: currentUser)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .tint(Color.hyTrackerBlue)
    }
}

#Preview {
    MainTabView(user: User.REPORT_MOCK_USER)
}
