//
//  ContentView.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    /*let columns = [
     GridItem(.adaptive(minimum: 150))
     ]*/
    
    var body: some View {
        //Text(String(astronauts.count))
        NavigationView{
            NavigationStack{
                    if showingGrid == true {
                        ScrollView{
                            GridLayout(missions: missions, astronauts: astronauts)
                        }
                        .background(.darkBackground)
                        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all)) // Updated background setting
                                    .preferredColorScheme(.dark)
                        .preferredColorScheme(.dark)
                    } else {
                            ListLayout(missions: missions, astronauts: astronauts)
                            .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
                                        .preferredColorScheme(.dark)
                    }
                
                
                    /*LazyVGrid(columns: columns){
                     ForEach(missions){ mission in
                     NavigationLink{
                     MissionView(mission: mission, astronauts: astronauts)
                     //Text("Detail View")
                     } label: {
                     VStack{
                     Image(mission.image)
                     .resizable()
                     .scaledToFit()
                     .frame(width: |, height: 100)
                     .padding()
                     
                     VStack{
                     Text(mission.displayName)
                     .font(.headline)
                     .foregroundStyle(.white)
                     
                     Text(mission.formattedLaunchDate /*launchDate ?? "N/A"*/)
                     .font(.caption)
                     .foregroundStyle(.gray)
                     }
                     .padding(.vertical)
                     .frame(maxWidth: .infinity)
                     .background(.lightBackground)
                     }
                     .clipShape(.rect(cornerRadius: 10))
                     .overlay(
                     RoundedRectangle(cornerRadius: 10)
                     .stroke(.lightBackground)
                     )
                     }
                     }
                     }
                     .padding([.horizontal, .bottom])
                     }*/
                }
                .navigationTitle("Moonshot")
                //.background(Color(.systemBackground).edgesIgnoringSafeArea(.all))

                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar{
                        Button(showingGrid == true ? "Show List View" : "Show Grid View"){
                            showingGrid.toggle()
                        
                    }
                }
            
            }
        
        }
    
    }

    
/*    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }*/
    
#Preview {
    ContentView()
}
