//
//  ContentView.swift
//  BucketList—Techniques
//
//  Created by Ciaran Murphy on 2/23/24.
//

import SwiftUI

struct User: Comparable, Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    let values = [1, 5, 3, 6, 2, 9].sorted()
    let users = [
    User(firstName: "Arnold", lastName: "Rimmer"),
    User(firstName: "Kristine", lastName: "Kochanski"),
    User(firstName: "David", lastName: "Lister")
    ]/*.sorted{
        $0.lastName < $1.lastName
    }*/
        .sorted()
    
    var body: some View {
        /*List(values, id: \.self){
            Text(String($0))
        }*/
        List(users){ user in
            Text("\(user.lastName), \(user.firstName)")
        }
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
