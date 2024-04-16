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

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Button("Tap me"){
            selectedUser = User()
            isShowingUser = true
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
                .presentationDetents([.medium, .large])
        }
//        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser){ user in
//            Button(user.id){
//                
//            }
//        }
    }
}

#Preview {
    ContentView()
}
