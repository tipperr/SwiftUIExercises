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
    
    enum CodingKeys: CodingKey {
            case id, isActive, name, age, company, email, address, about, registered, tags, friends
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        registered = try container.decode(String.self, forKey: .registered)
        tags = try container.decode([String].self, forKey: .tags)
        friends = try container.decode([Friend].self, forKey: .friends)
        
        /*// Print statements to track decoding process
                print("Decoding User with ID:", id)
                print("Decoding User with Name:", name)
                
                // Try decoding friends array
                do {
                    print("Decoding Friends")
                    friends = try container.decode([Friend].self, forKey: .friends)
                    print("Decoded Friends for User with ID:", id)
                } catch {
                    print("Failed to decode Friends for User with ID:", id)
                    print("Error:", error)
                }*/
    }
    
    
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(isActive, forKey: .isActive)
            try container.encode(name, forKey: .name)
            try container.encode(age, forKey: .age)
            try container.encode(company, forKey: .company)
            try container.encode(email, forKey: .email)
            try container.encode(address, forKey: .address)
            try container.encode(about, forKey: .about)
            try container.encode(registered, forKey: .registered) // No need for date formatting
            try container.encode(tags, forKey: .tags)
            try container.encode(friends, forKey: .friends)
        }
        
    
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
    
    enum CodingKeys: CodingKey{
        case id, name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        /*print("Decoding Friend with ID:", id)
        print("Decoding Friend with Name:", name)*/
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query/*(sort: \User.name)*/ private var users: [User]
    //@State private var users = [User]()
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
            let decoder = JSONDecoder()
            let downloadedUsers = try decoder.decode([User].self, from: data)
                        let insertContext = ModelContext(modelContext.container)

                        for user in downloadedUsers {
                            insertContext.insert(user)
                        }

                        try insertContext.save()
            //users = try JSONDecoder().decode([User].self, from: data)
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
