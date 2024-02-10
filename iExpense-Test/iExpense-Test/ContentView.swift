import SwiftData
import SwiftUI

@Model
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    // Conformance to Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        amount = try container.decode(Double.self, forKey: .amount)
    }
    
    // Conformance to Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(amount, forKey: .amount)
    }
    
    // Coding keys
    enum CodingKeys: String, CodingKey {
        case id, name, type, amount
    }
}

struct ContentView: View {

    @Environment(\.modelContext) var modelContext
    @Query private var expenses: [ExpenseItem]

    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    // Optionally display item type
                                    // Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(item.amount >= 100 ? .green : (item.amount >= 10 ? .red : .blue))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                .navigationTitle("iExpense")
                .toolbar {
                    Button("Add expense") {
                        showingAddExpense = true
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView()
                }
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        // Use SwiftData to delete the item from the database
        for index in offsets {
            modelContext.delete(expenses[index])
        }
    }
}


#Preview {
    ContentView()
}
