//
//  CrewView.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/22/24.
//

import SwiftUI

struct CrewView: View {
    
    let role: String
    let astronaut: Astronaut
    
    
    var body: some View {
        NavigationLink{
            //Text("Astronaut Details")
            AstronauatView(astronaut: astronaut)
        } label: {
            HStack{
                Image(astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(.capsule)
                    .overlay(
                        Capsule()
                            .stroke((role == "Command Pilot" || role == "Commander" ? .yellow : .white), lineWidth: 1)
                        )
                
                VStack(alignment: .leading){
                    Text(astronaut.name)
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    Text(role)
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
            
            .padding(.horizontal)
        }
    }
}

/*#Preview {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return CrewView(role: "Commander", astronaut: astronaut)
        .preferredColorScheme(.dark)
}*/
