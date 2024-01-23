//
//  GridLayout.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/22/24.
//

import SwiftUI

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    GridItems(mission: mission)
                }
            }
        }
        .padding([.horizontal, .bottom])
        .onAppear {
                print("GridLayout appeared")
            }
    }
    
}

/*#Preview {
    GridLayout()
}*/
