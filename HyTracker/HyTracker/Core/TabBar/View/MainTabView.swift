//
//  MainTabView.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/17/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        VStack {
            HTLogoView(size: .normal)
            
            Text("UNDER CONSTRUCTION: Main Tab View")
            
            Button(action: {
                AuthService.shared.signOut()
            }, label: {
                Text("SIGN OUT")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .frame(width: 300, height: 40)
                    .overlay {
                        Capsule()
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.black)
                    }
                    .padding()
            })
        }
    }
}

#Preview {
    MainTabView()
}
