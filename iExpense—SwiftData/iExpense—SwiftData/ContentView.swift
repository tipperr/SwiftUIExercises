//
//  ContentView.swift
//  iExpense
//
//  Created by Ciaran Murphy on 1/16/24.
//
import SwiftData
import SwiftUI

@Model
class ExpenseItem/*: Identifiable, Codable, Equatable*/ {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
    
}

/*@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}*/

struct ContentView: View {
    //@State private var expenses = Expenses()
    @Environment(\.modelContext) var modelContext
    @Query private var expenses: [ExpenseItem]
    @State private var showingAddExpense = false
    @State private var expenseType = "All"
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount),
    ]

    var body: some View {
        NavigationStack {
            ExpensesView(type: expenseType, sortOrder: sortOrder)
            /*List {
                ForEach(expenses) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)

                            Text(item.type)
                        }

                        Spacer()

                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }*/
            
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.amount),
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                    }
                }
                Menu("Filter", systemImage: "line.3.horizontal.decrease.circle"){
                    Picker("Filter", selection: $expenseType){
                        Text("Show All")
                            .tag("All")
                        
                        Divider()
                        
                        ForEach(AddView.types, id: \.self) { type in
                            Text(type)
                                .tag(type)
                        }
                    
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(/*expenses: expenses*/)
            }
        }
    }

    /*func removeItems(at offsets: IndexSet) {
        for offset in offsets{
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }*/
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
