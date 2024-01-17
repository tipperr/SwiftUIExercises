//
//  ContentView.swift
//  iExpense
//
//  Created by Ciaran Murphy on 1/16/24.
//

import SwiftUI

//Show and hiding views
/*struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Text("Hello, \(name)")
        Button("Dismiss"){
            dismiss()
        }
    }
}*/

//@Observable
/*class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}*/

struct ContentView: View {
    
    //Using UserDefaults"
    /*@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")*/
    
    //Using @AppStorage:
    @AppStorage("tapCount") private var tapCount = 0
    
    //@State private var numbers = [Int]()
    //@State private var currentNumber = 1
    
    //@State private var showingSheet = false
    
    //@State private var user = User()
    
    var body: some View {
        //NavigationStack{
            //VStack {
        Button("Tap Count: \(tapCount)"){
            tapCount += 1
            
            //UserDefaults is unecessary with @Appstorage
            //UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
                
                //Deleting items:
                /*List{
                    ForEach(numbers, id:\.self){
                        Text("Row \($0)")
                    }
                    .onDelete(perform: RemoveRows)
                }
                
                Button("Add Number"){
                    numbers.append(currentNumber)
                    currentNumber += 1
                }*/
                
                //Showing and hiding views
                /*Button("Show Sheet"){
                 showingSheet.toggle()
                 }
                 .sheet(isPresented: $showingSheet){
                 SecondView(name: "Ciarán")
                 }*/
                
                //Playing with @observable to change Classes
                /*Text("Your name is \(user.firstName) \(user.lastName)")
                 
                 TextField("First name ", text: $user.firstName)
                 TextField("Last name ", text: $user.lastName)*/
            }
            //Deleting items:
            /*.toolbar{
                EditButton()
            }
        }*/
        
    }
    //Deleting items
    /*func RemoveRows(at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }*/
//}

#Preview {
    ContentView()
}
