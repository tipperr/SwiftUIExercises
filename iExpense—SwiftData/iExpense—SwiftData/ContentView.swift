//
//  ContentView.swift
//  iExpense—SwiftData
//
//  Created by Ciaran Murphy on 2/9/24.
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

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            VStack{
                Text("My Expenses")
                    .font(.title)
                List{
                    ForEach(expenses.items /* not required due to "Identifiable", id:\.id*/){ item in
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(item.amount >= 100 ? .green : (item.amount >= 10 ? .red : .blue))
                            }
                        }
                    .onDelete(perform: removeItems)
                }
                
                }
                .navigationTitle("iExpense")
                .background(.pink)
                .toolbar{
                    Button("Add expense", systemImage: "plus"){
                        showingAddExpense = true
                        //This is for testing only:
                        /*let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                         expenses.items.append(expense)*/
                    }
                }
                .sheet(isPresented: $showingAddExpense){
                    AddView(expenses: expenses)
                }
            }
        }
    
    
    func removeItems(at offsets:IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
