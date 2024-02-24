//
//  ContentView.swift
//  BucketList—Techniques
//
//  Created by Ciaran Murphy on 2/23/24.
//

//Comparable Conformance
/*import SwiftUI

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
}*/


//Writing data to documents
/* import SwiftUI

 struct ContentView: View {
     var body: some View {
         Button("Read and Write"){
             let data = Data("Test Message".utf8)
             let url = URL.documentsDirectory.appending(path: "messages.txt")
             
             do {
                 try data.write(to: url, options: [.atomic, .completeFileProtection])
                 let input = try String(contentsOf: url)
                 print(input)
             } catch {
                 print(error.localizedDescription)
             }
         }
     }
     
     /*func test(){
         print(URL.documentsDirectory)
     }*/
 }

 #Preview {
     ContentView()
 }*/
//Switching view states with enums
import SwiftUI

struct LoadingView: View {
    var body: some View{
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        
        if loadingState == .loading{
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else {
            FailedView()
        }
        
        /*if Bool.random(){
            Rectangle()
        } else {
            Circle()
        }*/
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
