//
//  MissionView.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/20/24.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){ width, axis in
                        width * 0.6
                    }
                    .padding()
                
                Text((mission.formattedLaunchDate == "N/A" ? "Never Launched" : "Launch Date: \(mission.formattedLaunchDate)"))
                    .font(.title3)
                    .foregroundStyle(.secondary)
                
                
                VStack(alignment: .leading){
                    DrawRectangle()
                    /*Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)*/
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    DrawRectangle()
                    
                    /*Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)*/
                    
                    Text("Crew")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(crew, id:\.role) { CrewMember in
                            CrewView(role: CrewMember.role, astronaut: CrewMember.astronaut)
                            /*NavigationLink{
                                //Text("Astronaut Details")
                                AstronauatView(astronaut: CrewMember.astronaut)
                            } label: {
                                HStack{
                                    Image(CrewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .stroke((CrewMember.role == "Command Pilot" || CrewMember.role == "Commander" ? .yellow : .white), lineWidth: 1)
                                            )
                                    
                                    VStack(alignment: .leading){
                                        Text(CrewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        
                                        Text(CrewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }
                                
                                .padding(.horizontal)
                            }*/
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
