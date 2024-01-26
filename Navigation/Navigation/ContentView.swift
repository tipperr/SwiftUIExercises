//
//  ContentView.swift
//  Navigation
//
//  Created by Ciaran Murphy on 1/23/24.
//

import SwiftUI

/*struct DetailVIew: View {
    
    var number: Int
    
    var body: some View{
        Text("Detail view \(number)")
    }
    
    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}*/

/*struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}*/

/*@Observable
class PathStore {
    //for various kinds of data types:
    //var path: NavigationPath
    
    //for homogeneous data types:
    var path: [Int]{
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath){
            //for various data types:
            //if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation, from: data){
                    //path = NavigationPath(decoded)
                    //return
                    //}
            
            //for homogeneous data types:
            if let decoded = try? JSONDecoder().decode([Int].self, from: data){
                path = decoded
                return
            }
        }
        
        //for various data types:
        //path = NavigationPath()
        
        //for homogeneous data types:
        path = []
    }
    
    func save(){
        
        //only if needed for various data types:
        //guard let representation = path.codable else { return }
        
        do {
            //for various data types:
            //let data = try JSONEncoder().encode(representation)
            
            //for homogeneous data types:
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int
    @Binding var path: [Int]
    
    var body: some View{
        NavigationLink("Go to random number", value: Int.random(in: 1..<1000))
            .navigationTitle("Number: \(number)")
            .toolbar{
                Button("Home"){
                    path.removeAll()
                }
            }
    }
}*/

struct ContentView: View {
    
    @State private var title = "SwiftUI"
    
    //@State private var path = [Int]()
    //@State private var path = NavigationPath()
    //Also for various types of data:
    //@State private var pathStore = PathStore()
    
    var body: some View {
        
        
        NavigationStack{
            Text("Hello World")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
        
        //Placing toolbar buttons
        /*NavigationStack{
            Text("Hello World")
                .toolbar{
                    //ToolbarItem(placement: .confirmationAction/*.topBarLeading*/){
                    ToolbarItemGroup(placement: .topBarLeading){
                        Button("Tap me"){
                        }
                        Button("Or Tap me"){
                        }
                    }
                }
                .navigationBarBackButtonHidden()
        }*/
        
        //Customizing navigation bar appearance
        /*NavigationStack{
            List(0..<100){ i in
                Text("Row \(i)")
            }
            .navigationTitle("Title Goes Here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            .toolbar(.hidden, for: .navigationBar)
        }*/
        
        /*NavigationStack(path: $pathStore.path){
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self){ i in
                    DetailView(number: i, path: $path)
                }
        }*/
        
        
        //Navigating to different data types
        /*NavigationStack(path: $path){
            List{
                ForEach(0..<5){ i in
                    NavigationLink("Select number: \(i)", value: i)
                }
                
                ForEach(0..<5){ i in
                    NavigationLink("Select string: \(i)", value: String(i))
                }
            }
            .toolbar{
                Button("Push 556"){
                    path.append(556)
                }
                
                Button("Push Hello"){
                    path.append("Hello")
                }
            }
            .navigationDestination(for: Int.self){ selection in
                Text("You selected the number \(selection)")
            }
            
            .navigationDestination(for: String.self){ selection in
                Text("You selected the string \(selection)")
            }
        }*/
        
        
        
        //Programmatic navigation:
        /*NavigationStack(path: $path){
            VStack{
                Button("32"){
                    path = [32]
                }
                Button("64"){
                    path.append(64)
                }
                Button("Show 32 then 64"){
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            
        }*/
        
        
        /*NavigationStack{
            //NavigationLink("Tap Me!"){
                //DetailVIew(number: 556)
            List(0..<100){ i in
                NavigationLink("Select \(i)", value: i)
                }
            .navigationDestination(for: Int.self){ selection in
                Text("You selected \(selection)")
            }
            }*/
        }
    }

#Preview {
    ContentView()
}
