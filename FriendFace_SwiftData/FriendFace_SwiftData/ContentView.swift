//
//  ContentView.swift
//  FriendFace_SwiftData
//
//  Created by Ciaran Murphy on 2/14/24.
//
import SwiftData
import SwiftUI

/*struct Response: Codable {
    var users: [User]
    var friends: [Friend]
}*/

@Model
class User: Codable {
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
    
    init(id: String, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: String, tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
}

@Model
class Friend: Codable {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var users = [User]()
    @State private var hasLoadedData = false
    
    var body: some View {
        NavigationStack{
            List(users, id: \.id){ user in
                //VStack(alignment: .leading){
                NavigationLink(destination: UserView(user: user)){
                    HStack{
                        Text(user.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(user.isActive ? "Online" : "Offline")
                            .foregroundStyle(user.isActive ? .green : .secondary)
                    }
                }
            }
            .task {
                if !hasLoadedData { // Check if data has been loaded
                                   await loadData()
                                   hasLoadedData = true // Set the flag to true after data is loaded
                               }
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
            //print(String(data: data, encoding: .utf8) ?? "Invalid data")
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
