//
//  ContentView.swift
//  BucketList—Techniques
//
//  Created by Ciaran Murphy on 2/23/24.
//

import SwiftUI

struct ContentView: View {
    let values = [1, 5, 3, 6, 2, 9]
    
    var body: some View {
        List(values, id: \.self){
            Text(String($0))
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
