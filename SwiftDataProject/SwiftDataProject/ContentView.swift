//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Ciaran Murphy on 2/7/24.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    /*@Query(filter: #Predicate<User> { user in
        //user.name.contains("R")
        user.name.localizedStandardContains("R") &&
        user.city == "London"
    },
        sort: \User.name) var users: [User]*/
    //Removed for "Filtering @Query using #Predicate"
    //@State private var path = [User]()
    
    var body: some View {
        NavigationStack(/*Removed for Filtering @Query using #Predicate: path: $path*/){
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast,
                      sortOrder: sortOrder
            )
            /*List(users){ user in
                //Removed for "Filtering @Query using #Predicate"
                //NavigationLink(value: user){
                    Text(user.name)
                //}
            }*/
                .navigationTitle("Users")
                //Removed for "Filtering @Query using #Predicate"
                /*.navigationDestination(for: User.self){ user in
                    EditUserView(user: user)
                }*/
                .toolbar{
                    //Removed for "Filtering @Query using #Predicate"
                    /*Button("Add user", systemImage: "plus"){
                     let user = User(name: "", city: "", joinDate: .now)
                     modelContext.insert(user)
                     path = [user]
                     }*/
                    Button("Add Sample", systemImage: "plus"){
                        try? modelContext.delete(model: User.self)
                        
                        let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                        let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                        let fourth = User(name: "Johnny English ", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                        
                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }
                    
                    Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming"){
                        showingUpcomingOnly.toggle()
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortOrder){
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])
                            Text("Sort by join date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                ])
                        }
                    }
                }
            }
        }
    }

#Preview {
    ContentView()
}
