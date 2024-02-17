//
//  WeeklyRequirementsSheet.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct WeeklyRequirementsSheet: View {
    @Binding var requiredDaysCount: Int
    let maxNumber: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                HTLogoView(size: .normal)
                
                Text("Setting your number of required in-office days helps analytics understand your target goals.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding([.horizontal], 24)
                
                Text("Please select your minimum required number of in-office days per week below:")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding([.horizontal, .top], 24)
                
                Picker("Select required days count", selection: $requiredDaysCount) {
                    ForEach(1 ... maxNumber, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .onAppear {
                    if requiredDaysCount == 0 {
                        // Default to the min if no selection has been made yet.
                        requiredDaysCount = 1
                    }
                }
                .pickerStyle(WheelPickerStyle()) // Gives the wheel appearance
                .padding(.horizontal, 100)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    SheetDoneLabel()
                })
            }
            .navigationTitle("Required Days Per Week")
            .navigationBarTitleDisplayMode(.inline)
            .fontDesign(.serif)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(HyTrackerGradient())
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // Cancel: Set ineligible count to indicate no selection made.
                        requiredDaysCount = 0
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(.subheadline)
                            .fontDesign(.serif)
                    })
                }
            }
        }
    }
}

#Preview {
    WeeklyRequirementsSheet(requiredDaysCount: .constant(1), maxNumber: 5)
}
