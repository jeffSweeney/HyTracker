//
//  MainTabView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel: MainTabViewModel
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: MainTabViewModel(user: user))
    }
    
    var body: some View {
        TabView {
            TrackDaysView(viewModel: viewModel)
                .tabItem {
                    Label("Track", systemImage: "calendar.badge.clock")
                }
            
            GenerateReportView(user: viewModel.user)
                .tabItem {
                    Label("Report", systemImage: "chart.xyaxis.line")
                }
            
            ProfileView(viewModel: viewModel)
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
