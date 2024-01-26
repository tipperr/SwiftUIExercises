//
//  ContentView.swift
//  iExpense
//
//  Created by Ciaran Murphy on 1/26/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
    didSet {
        if let encoded = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}


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


//Using Codeable:
/*struct User: Codable {
    var firstName: String
    var lastName: String
}*/

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    
//Ignode all @States below
    //Using Codeable:
    /*@State private var user = User(firstName: "Taylor", lastName: "Swift")*/
    
    //Using UserDefaults"
    /*@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")*/
    
    //Using @AppStorage:
    //@AppStorage("tapCount") private var tapCount = 0
    
    //@State private var numbers = [Int]()
    //@State private var currentNumber = 1
    
    //@State private var showingSheet = false
    
    //@State private var user = User()
    
    var body: some View {
        NavigationStack {
            VStack{
                
                /*Button("Add Expense"){
                    AddView(expenses: expenses)
                }
                .font(.title)*/
                Spacer()
                Rectangle()
                    .fill(.white)
                    .frame(height: 3)
                
                NavigationLink("Add Expense"){
                    AddView(expenses: expenses)
                }
                .font(.title.bold())
                .foregroundStyle(.secondary)
                
                Spacer()
                
                Rectangle()
                    .fill(.white)
                    .frame(height: 3)
                
                Spacer()
                
                Text("Personal Expenses")
                    .font(.title)
                List{
                    ForEach(expenses.items /* not required due to "Identifiable", id:\.id*/){ item in
                        if item.type == "Personal"{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    //Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(item.amount >= 100 ? .green : (item.amount >= 10 ? .red : .blue))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Text("Business Expenses")
                    .font(.title)
                List{
                    ForEach(expenses.items /* not required due to "Identifiable": id:\.id*/){ item in
                        if item.type == "Business"{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    //Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(item.amount >= 100 ? .green : (item.amount >= 10 ? .red : .blue))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                }
                .navigationTitle("iExpense")
                .background(.pink)
                /*.toolbar{
                    Button("Add expense", systemImage: "plus"){
                        showingAddExpense = true
                        //This is for testing only:
                        /*let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                         expenses.items.append(expense)*/
                    }
                }
                .sheet(isPresented: $showingAddExpense){
                    AddView(expenses: expenses)
                }*/
            }
        }
    
    
    func removeItems(at offsets:IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}
//Ignore all code below
        //Using Codeable:
        /*Button("Save User"){
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user){
                UserDefaults.standard.set(data, forKey: "UserData")
            }*/
        
        //NavigationStack{
            //VStack {
        
        //This button saves data automatically with @AppStorage, but requires additional code with UserDefaults
        /*Button("Tap Count: \(tapCount)"){
            tapCount += 1*/
            
            //UserDefaults is unecessary with @Appstorage
            //UserDefaults.standard.set(tapCount, forKey: "Tap")
        
                
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
            
            //Deleting items:
            /*.toolbar{
                EditButton()
            }
        }*/
        
    
    //Deleting items
    /*func RemoveRows(at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }*/
//}

#Preview {
    ContentView()
}
