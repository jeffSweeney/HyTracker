//
//  HyTrackerGradient.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/10/24.
//

import SwiftUI

struct HyTrackerGradient: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .background(LinearGradient(gradient: Gradient(colors: [.white, .blue]),
                                       startPoint: .top,
                                       endPoint: .bottom))
    }
}
