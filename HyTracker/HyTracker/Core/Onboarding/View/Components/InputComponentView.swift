//
//  InputComponentView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/11/24.
//

import SwiftUI

struct InputComponentView: View {
    let component: InputComponent
    let isActionable: Bool
    
    var symbolName: String {
        if component.hasInput { return "checkmark" }
        
        return isActionable ? "pencil" : "pencil.slash"
    }
    
    var body: some View {
        HStack {
            Text(component.textLabel)
                .fontWeight(component.hasInput ? .bold : .none)
            
            Spacer()
            
            Image(systemName: symbolName)
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
    InputComponentView(component: .startDate(nil), isActionable: true)
}
