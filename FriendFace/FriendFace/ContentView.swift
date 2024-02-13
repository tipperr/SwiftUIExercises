//
//  ContentView.swift
//  FriendFace
//
//  Created by Ciaran Murphy on 2/12/24.
//

import SwiftUI

struct Response: Codable {
    var users: [User]
    var friends: [Friend]
}

struct User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable {
    var id: String
    var name: String
}

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack{
            List(users, id: \.id){ user in
                VStack(alignment: .leading){
                    Text(user.name)
                        .font(.headline)
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print("Invalid data")
        }
        
        //print(String(data: data, encoding: .utf8) ?? "Invalid data")
    }
}

#Preview {
    ContentView()
}
