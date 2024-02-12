//
//  ExpensesView.swift
//  iExpense—SwiftData
//
//  Created by Ciaran Murphy on 2/11/24.
//
import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        List {
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
        }
    }
    init(type: String = "All", sortOrder: [SortDescriptor<ExpenseItem>]) {
            _expenses = Query(filter: #Predicate {
                if type == "All" {
                    return true
                } else {
                    return $0.type == type
                }
            }, sort: sortOrder)
        }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets{
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpensesView(sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
