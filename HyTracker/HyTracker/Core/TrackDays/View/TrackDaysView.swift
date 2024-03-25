//
//  TrackDaysView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/22/24.
//

import SwiftUI

struct TrackDaysView: View {
    @StateObject var viewModel: TrackDaysViewModel
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: TrackDaysViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
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
                        
                        Text(viewModel.today.asFullHyTrackerDate)
                            .font(.subheadline)
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                Task { try await viewModel.uploadToday(as: .inOffice) }
                            }, label: {
                                HTPrimaryButton(screen: .inOffice, isActionable: true, size: .split)
                            })
                            
                            Button(action: {
                                Task { try await viewModel.uploadToday(as: .exempt) }
                            }, label: {
                                HTPrimaryButton(screen: .exempt, isActionable: true, size: .split)
                            })
                        }
                    }
                    .alert(viewModel.alert?.title ?? "Alert", isPresented: $viewModel.showingAlert, actions: {
                        Button(viewModel.alert?.buttonTitle ?? "OK") {
                            viewModel.showingAlert = false
                            viewModel.alert = nil
                        }
                    }, message: {
                        Text(viewModel.alert?.message ?? "Unknown result. Check Bulk Track section for change confirmation.")
                            .font(.subheadline)
                    })
                    
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
                            NavigationLink {
                                BulkUpdatesView(context: .inOffice, viewModel: viewModel)
                            } label: {
                                HTPrimaryButton(screen: .inOffice, isActionable: true, size: .split)
                            }
                            
                            NavigationLink {
                                BulkUpdatesView(context: .exempt, viewModel: viewModel)
                            } label: {
                                HTPrimaryButton(screen: .exempt, isActionable: true, size: .split)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .fontDesign(.serif)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(HyTrackerGradient())
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                // Keeps the date fresh when coming into foreground
                viewModel.today = Date.today
            }
        }
    }
}

#Preview {
    TrackDaysView(user: User.BASIC_MOCK_USER)
}
