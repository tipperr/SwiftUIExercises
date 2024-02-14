//
//  UserView.swift
//  FriendFace_SwiftData
//
//  Created by Ciaran Murphy on 2/14/24.
//

import SwiftData
import SwiftUI

struct UserView: View {
    @Environment(\.modelContext) var modelContext
    let user: User
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("User Details: ")
                    .font(.title)
                List{
                    HStack{
                        Text("User ID: ")
                            .font(.headline)
                        Spacer()
                        Text(user.id)
                    }
                    .listRowBackground(Color.blue)
                    HStack{
                        Text("User Status: ")
                            .font(.headline)
                        Spacer()
                        Text(user.isActive ? "Online" : "Offline")
                    }
                    .listRowBackground(user.isActive ? Color.blue : Color.secondary)
                    HStack{
                        Text("User Age: ")
                            .font(.headline)
                        Spacer()
                        Text(String(user.age))
                    }
                    .listRowBackground(Color.blue)
                    HStack{
                        Text("User Company: ")
                            .font(.headline)
                        Spacer()
                        Text(user.company)
                    }
                    .listRowBackground(Color.blue)
                    HStack{
                        Text("User Email: ")
                            .font(.headline)
                        Spacer()
                        Text(user.email)
                    }
                    .listRowBackground(Color.blue)
                    HStack{
                        Text("User Address: ")
                            .font(.headline)
                        Spacer()
                        Text(user.address)
                    }
                    .listRowBackground(Color.blue)
                    HStack{
                        Text("About User: ")
                            .font(.headline)
                        Spacer()
                        Text(user.about)
                    }
                    .listRowBackground(Color.blue)
                    HStack{
                        Text("Date Registered: ")
                            .font(.headline)
                        Spacer()
                        Text(user.registered)
                    }
                    .listRowBackground(Color.blue)
                }
                
                //VStack{
                /*Text("User ID: \(user.id)")
                 .padding()
                 Text("User Online: \((user.isActive ? "Online" : "Offline"))")
                 .padding()
                 Text("Age \(String(user.age))")
                 .padding()
                 Text("Company: \(user.company)")
                 .padding()
                 Text("Email: \(user.email)")
                 .padding()
                 Text("Address: \(user.address)")
                 .padding()
                 Text("About user: \(user.about)")
                 .padding()
                 Text("Date registered: \(user.registered)")
                 .padding()*/
                
                Spacer()
                
                Text("User Tags:")
                    .font(.title)
                List(user.tags, id: \.self) { tag in
                    Text(tag)
                        .listRowBackground(Color.blue)
                        .padding()
                    
                }
                .listRowBackground(Color.blue)
                
                Spacer()
                
                Text("User Friends:")
                    .font(.title)
                List(user.friends.map { $0.name }, id: \.self) { friendName in
                    Text(friendName)
                        .listRowBackground(Color.blue)
                        .padding()
                    
                }
                .listRowBackground(Color.blue)
            }
            .background(.gray)
        }
            
            .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)

    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample User object for preview
        let user = User(id: "123", isActive: false, name: "John Doe", age: 30, company: "Swiftify", email: "john@example.com", address: "123 Main St", about: "Lorem ipsum dolor sit amet", registered: "2022-01-01", tags: ["tag1", "tag2"], friends: [])
        
        // Preview UserView with the sample User object
        UserView(user: user)
    }
}
/*#Preview {
    UserView()
}*/
