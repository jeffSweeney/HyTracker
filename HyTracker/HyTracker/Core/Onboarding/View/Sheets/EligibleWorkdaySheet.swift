//
//  EligibleWorkdaySheet.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct EligibleWorkdaySheet: View {
    @Binding var eligibleWorkdays: Set<Weekday>
    @State private var originalWorkdays: Set<Weekday> = [] // Save intitial state in case we cancel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer()
                
                HTLogoView(size: .normal)
                
                Text("Selecting your eligible workdays helps us calculate which days should and shouldn't count toward your analytics.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding([.horizontal, .bottom], 24)
                
                VStack(spacing: 0) {
                    ForEach(Weekday.allCases) { weekday in
                        VStack(spacing: 0) {
                            HStack {
                                Text(weekday.label)
                                
                                Spacer()
                                
                                if eligibleWorkdays.contains(weekday) {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .padding(.horizontal)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if eligibleWorkdays.contains(weekday) {
                                    eligibleWorkdays.remove(weekday)
                                } else {
                                    eligibleWorkdays.insert(weekday)
                                }
                            }
                            .padding()
                            .background(Color.clear)
                            
                            Divider()
                        }
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(lineWidth: 1)
                }
                .padding()
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    SheetDoneLabel()
                })
            }
            .navigationTitle("Eligible Workdays Selection")
            .navigationBarTitleDisplayMode(.inline)
            .fontDesign(.serif)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(HyTrackerGradient())
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        eligibleWorkdays = originalWorkdays
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(.subheadline)
                            .fontDesign(.serif)
                    })
                }
            }
            .onAppear {
                originalWorkdays = eligibleWorkdays
            }
        }
    }
}

#Preview {
    EligibleWorkdaySheet(eligibleWorkdays: .constant([]))
}
