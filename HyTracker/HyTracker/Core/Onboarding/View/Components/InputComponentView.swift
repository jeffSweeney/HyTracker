//
//  InputComponentView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct InputComponentView: View {
    let component: InputComponent
    
    var body: some View {
        HStack {
            Text(component.textLabel)
                .fontWeight(component.hasInput ? .bold : .none)
            
            Spacer()
            
            Image(systemName: component.hasInput ? "checkmark" : "pencil")
                .fontWeight(component.hasInput ? .bold : .none)
        }
        .padding()
        .frame(width: 300, height: 40)
        .overlay {
            Capsule()
                .stroke(lineWidth: 1)
        }
    }
}

#Preview {
    InputComponentView(component: .startDate(nil))
}
