//
//  ListLayout.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/22/24.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        
        //VStack{
            /*Text("ListLayout")
                .padding()
            
            Text("Number of missions: \(missions.count)")*/
            
            List(missions) { mission in
                //print("Mission: \(mission)")
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    //Text("Mission: \(mission.displayName)")
                    
                    ListItems(mission: mission)
                }
            }
            .listStyle(PlainListStyle())
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            /*.onAppear {
                print("ListLayout appeared")
                print("Number of missions in ListLayout: \(missions.count)")
            }*/
        }
        //.background(.darkBackground)
       // .preferredColorScheme(.dark)
        
    }


