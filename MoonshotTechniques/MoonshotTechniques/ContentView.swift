//
//  ContentView.swift
//  MoonshotTechniques
//
//  Created by Ciaran Murphy on 1/19/24.
//

import SwiftUI

struct User: Codable{
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

/*struct CustomText: View {
    let text: String
    var body: some View{
        Text(text)
    }
    
    init(text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}*/

struct ContentView: View {
    
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
                 ]
        /*GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))*/

    
    var body: some View {
        
        ScrollView(.horizontal){
            LazyHGrid(rows: layout){
                ForEach(0..<1000){
                    Text("Item \($0)")
                }
            }
        }
        
        //Working with hierarchical codable data
        /*Button("Decode JSON"){
            let input = """
                    {
                    "name": "Taylor Swift"
                    "address": {
                        "street": "555, Taylor Swift Avenue"
                        "city": "Nashville"
                    }
                        }
                    """
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(User.self, from: data){
                print(user.address.street)
            }
        }*/
        
        /*NavigationStack{
            //Text("Tap Me")
            
            List(0..<10){ row in
                NavigationLink("Row \(row)"){
                    Text("Detail \(row)")
                }
            }
            
            /*NavigationLink/*("Tap me")*/{
                Text("Detail View")
            } label: {
                VStack{
                    Text("This is the label")
                    Text("So is this")
                    Image(systemName: "face.smiling")
                }
                .font(.title)
            }*/
                .navigationTitle("SwiftUI")
        }*/
        
        //ScrollView, Lazystacks:
        /*ScrollView(.horizontal){
            LazyHStack(spacing: 10){
                ForEach(0..<100){
                    //Text("Item: \($0)")
                    CustomText(text: "Item: \($0)")
                        .font(.title)
                }
            }
            //.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }*/
        
        //Resizing Images:
        /*Image(.young)
         .resizable()
         .scaledToFit()
         //.frame(width: 300, height: 300)
         .containerRelativeFrame(.horizontal) { size, axis in
         size * 0.8
         }
         }*/
    }
}

#Preview {
    ContentView()
}
