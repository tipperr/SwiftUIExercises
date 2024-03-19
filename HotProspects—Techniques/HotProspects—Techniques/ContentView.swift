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


//Result:
/* import SwiftUI

 struct ContentView: View {
     @State private var output = ""
     
     var body: some View {
        Text(output)
             .task {
                 await fetchReadings()
             }
     }
     
     func fetchReadings() async {
         //do {
         let fetchTask = Task{
             let url = URL(string: "https://hws.dev/readings.json")!
             let (data, _) = try await URLSession.shared.data(from: url)
             let readings = try JSONDecoder().decode([Double].self, from:  data)
             //output = "Found \(readings.count) readings"
             return "Found \(readings.count) readings"
         }
         
         let result = await fetchTask.result
         
         switch result {
         case .success(let str):
             output = str
         case .failure(let error):
             output = "Error: \(error.localizedDescription)"
         }
         
         /*do {
             output = try result.get()
         } catch {
             output = "Error: \(error.localizedDescription)"
         }*/
         
         /*catch {
             print("Download Error")
         }*/
     }
 }

 #Preview {
     ContentView()
 }*/

 


/* import SwiftUI

 struct ContentView: View {
     var body: some View {
         Image(.example)
             .interpolation(.none)
             .resizable()
             .scaledToFit()
             .background(.black)
     }
 }

 #Preview {
     ContentView()
 }*/

 

/*
 import SwiftUI

 struct ContentView: View {
     @State private var backgroundColor = Color.red
     
     var body: some View {
         VStack {
             Text("Hello, World!")
                 .padding()
                 .background(backgroundColor)
             
             Text("Change Color")
                 .padding()
                 .contextMenu(ContextMenu(menuItems: {
                     Button("Red", systemImage: "checkmark.circle.fill"){
                         backgroundColor = .red
                     }
                     Button("Green"){
                         backgroundColor = .green
                     }
                     Button("Blue"){
                         backgroundColor = .blue
                     }
                 }))
         }
     }
 }

 #Preview {
     ContentView()
 }*/

/*
 import SwiftUI

 struct ContentView: View {
     var body: some View {
         List {
             Text("Taylor Swift")
                 .swipeActions {
                     Button("Delete", systemImage: "minus.circle", role: .destructive){
                         print("Delete")
                     }
                     Button("Send Message", systemImage: "message"){
                         print("Hi")
                     }
                 }
                 .swipeActions(edge: .leading){
                     Button("Pin", systemImage: "pin"){
                         print("Pinning")
                     }
                     .tint(.orange)
                 }
         }
     }
 }

 #Preview {
     ContentView()
 }*/


/*
 import SwiftUI
import UserNotifications

 struct ContentView: View {
     var body: some View {
         VStack {
             Button("Request Permission"){
                 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){ success, error in
                     if success{
                         print("All set!")
                     } else if let error {
                         print("Error:\(error.localizedDescription)")
                     }
                 }
             }
             .padding()
             Button("Schedule Notification"){
                 let content = UNMutableNotificationContent()
                 content.title = "Feed the cat"
                 content.subtitle = "It looks hungry"
                 content.sound = UNNotificationSound.default
                 
                 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                 
                 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                 
                 UNUserNotificationCenter.current().add(request)
             }
             .padding()
         }
     }
 }

 #Preview {
     ContentView()
 }*/


import SamplePackage
 import SwiftUI

 struct ContentView: View {
     let possibleNumbers = 1...60
     
     var results: String {
         let selected = possibleNumbers.random(7).sorted()
         let strings = selected.map(String.init)
         return strings.formatted()
     }
     
     var body: some View {
         Text(results)
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
