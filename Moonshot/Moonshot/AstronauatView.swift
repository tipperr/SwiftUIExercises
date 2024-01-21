//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/21/24.
//

import SwiftUI

struct AstronauatView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return AstronauatView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
