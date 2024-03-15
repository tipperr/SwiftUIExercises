//
//  ContentView.swift
//  HotProspects—Techniques
//
//  Created by Ciaran Murphy on 3/14/24.
//

//Selecting Multiple items in a list
/*import SwiftUI

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    //@State private var selection: String?
    @State private var selection = Set<String>()
    
    
    var body: some View {
        List(users, id:\.self, selection: $selection) { user in
            Text(user)
        }
        
        //if let selection {
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
        
        EditButton()
    }
}

#Preview {
    ContentView()
}*/



 /*import SwiftUI

 struct ContentView: View {
     @State private var selectedTab = "One"
     
     var body: some View {
         TabView(selection: $selectedTab){
             //Text("Tab 1")
             Button("Show Tab 2"){
                 selectedTab = "Two"
             }
             .tabItem {
                 Label("One", systemImage: "star")
             }
             .tag("One")
             
             
             Text("Tab 2")
                 .tabItem {
                     Label("Two", systemImage: "circle")
                 }
                 .tag("Two")
         }
     }
 }

 #Preview {
     ContentView()
 }*/



 import SwiftUI

 struct ContentView: View {
     var body: some View {
         VStack {
             Image(systemName: "globe")
                 .imageScale(.large)
                 .foregroundStyle(.tint)
             Text("Hello, world!")
         }
         .padding()
     }
 }

 #Preview {
     ContentView()
 }

 

/*
 import SwiftUI

 struct ContentView: View {
     var body: some View {
         VStack {
             Image(systemName: "globe")
                 .imageScale(.large)
                 .foregroundStyle(.tint)
             Text("Hello, world!")
         }
         .padding()
     }
 }

 #Preview {
     ContentView()
 }

 */
