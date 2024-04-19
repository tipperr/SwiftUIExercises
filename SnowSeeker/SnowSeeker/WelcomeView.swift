//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Ciaran Murphy on 4/18/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            
            Text("Please select a resort from the left hand menu")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
