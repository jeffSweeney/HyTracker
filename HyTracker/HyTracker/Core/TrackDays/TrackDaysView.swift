//
//  TrackDaysView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct TrackDaysView: View {
    @ObservedObject var viewModel: MainTabViewModel
    @State private var numsChecked: Set<Int> = []
    
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
                .padding(.vertical)
            
            Text("Mark yourself present or make the day exempt for the most accurate, up-to-date analytics.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding([.horizontal, .bottom], 24)
            
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Quick Track")
                        .font(.headline)
                    
                    Text(Date.now.asFullHyTrackerDate)
                        .font(.subheadline)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            print("DEBUG: Tapped In-Office")
                        }, label: {
                            HTPrimaryButton(style: .split, screen: .inOffice, isActionable: true)
                        })
                        
                        Button(action: {
                            print("DEBUG: Tapped Exempt")
                        }, label: {
                            HTPrimaryButton(style: .split, screen: .exempt, isActionable: true)
                        })
                    }
                }
                
                // TODO: --- OR ---
                
                // TODO: Bulk Uploads
            }
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
    }
}

#Preview {
    TrackDaysView(viewModel: MainTabViewModel(user: User.BASIC_MOCK_USER))
}
