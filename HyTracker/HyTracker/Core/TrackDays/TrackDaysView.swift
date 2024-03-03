//
//  TrackDaysView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct TrackDaysView: View {
    @ObservedObject var viewModel: MainTabViewModel
    
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
                            print("DEBUG: Tapped QT In-Office")
                        }, label: {
                            HTPrimaryButton(style: .split, screen: .inOffice, isActionable: true)
                        })
                        
                        Button(action: {
                            print("DEBUG: Tapped QT Exempt")
                        }, label: {
                            HTPrimaryButton(style: .split, screen: .exempt, isActionable: true)
                        })
                    }
                }
                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                    
                    Text("OR")
                        .font(.subheadline)
                    
                    Rectangle()
                        .frame(height: 1)
                }
                .padding(.horizontal, 24)
                
                VStack(spacing: 8) {
                    Text("Bulk Track")
                        .font(.headline)
                    
                    Text("Update multiple days at once")
                        .font(.subheadline)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            print("DEBUG: Tapped BT In-Office")
                        }, label: {
                            HTPrimaryButton(style: .split, screen: .inOffice, isActionable: true)
                        })
                        
                        Button(action: {
                            print("DEBUG: Tapped BT Exempt")
                        }, label: {
                            HTPrimaryButton(style: .split, screen: .exempt, isActionable: true)
                        })
                    }
                }
            }
            
            Spacer()
        }
        .fontDesign(.serif)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HyTrackerGradient())
    }
}

#Preview {
    TrackDaysView(viewModel: MainTabViewModel(user: User.BASIC_MOCK_USER))
}
