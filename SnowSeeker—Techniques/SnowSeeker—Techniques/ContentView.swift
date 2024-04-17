//
//  ContentView.swift
//  SnowSeeker—Techniques
//
//  Created by Ciaran Murphy on 4/16/24.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group{
            Text("Name: Ciarán")
            Text("Location: NYC")
            Text("Pets: Orla and Ned")
        }
        .font(.title)
    }
}

//struct ContentView: View {
//    var body: some View {
//        //NavigationSplitView(columnVisibility: .constant(.all)){
//        NavigationSplitView(preferredCompactColumn: .constant(.detail)){
//            NavigationLink("Primary"){
//                Text("New View")
//            }
//        } detail: {
//            Text("Content")
//        }
//        .navigationSplitViewStyle(.balanced)
//    }
//}

//struct ContentView: View {
//    @State private var selectedUser: User? = nil
//    @State private var isShowingUser = false
//    
//    var body: some View {
//        Button("Tap me"){
//            selectedUser = User()
//            isShowingUser = true
//        }
//        .sheet(item: $selectedUser) { user in
//            Text(user.id)
//                .presentationDetents([.medium, .large])
//        }
////        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser){ user in
////            Button(user.id){
////                
////            }
////        }
//    }
//}

//struct ContentView: View {
//    @State private var layoutVertically = false
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
//    
//    var body: some View {
//        
//        ViewThatFits{
//            Rectangle()
//                .frame(width: 500, height: 200)
//            
//            Circle()
//                .frame(width: 200, height: 200)
//        }
//        
////        if horizontalSizeClass == .compact {
////            //if layoutVertically {
////                VStack{
////                    UserView()
////                }
////            } else {
////                HStack {
////                    UserView()
////                }
////            }
//        
//        
////        Button{
////            layoutVertically.toggle()
////        } label: {
////            if layoutVertically {
////                VStack{
////                    UserView()
////                }
////            } else {
////                HStack {
////                    UserView()
////                }
////            }
////        }
//    }
//}

//struct ContentView: View {
//    @State private var searchText = ""
//    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
//    
//    var filteredNames: [String] {
//        if searchText.isEmpty{
//            allNames
//        } else {
//            allNames.filter{ name in
//                name.localizedStandardContains(searchText)
//            }
//        }
//    }
//    
//    var body: some View {
//        NavigationStack{
//            //Text("Searching for \(searchText)")
//            List(filteredNames, id: \.self){ name in
//                Text(name)
//            }
//                .searchable(text: $searchText, prompt: "Look for something")
//                .navigationTitle("Searching")
//        }
//    }
//}

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    //var player: Player
    @Environment(Player.self) var player

    
    var body: some View {
        Text("Your High Score Is: \(player.highScore)")
    }
}

struct ContentView: View {
    @State private var player = Player()
    
    var body: some View {
        VStack{
            Text("Welcome!")
            //HighScoreView(/*player: player*/)
            HighScoreView()
        }
        .environment(player)
    }
}

#Preview {
    ContentView()
}
