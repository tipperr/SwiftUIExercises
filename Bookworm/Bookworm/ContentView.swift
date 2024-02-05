//
//  ContentView.swift
//  Bookworm
//
//  Created by Ciaran Murphy on 2/5/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    @State private var showingAddScreen = false
    var body: some View {
        NavigationStack{
            Text("Count is: \(books.count)")
                .navigationTitle("Bookworm")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Add Book", systemImage: "plus"){
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen){
                    AddBookView()
                }
        }
    }
}

#Preview {
    ContentView()
}
