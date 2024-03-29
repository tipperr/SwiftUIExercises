//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Ciaran Murphy on 1/16/24.
//
import SwiftData
import SwiftUI

@main
struct iExpense_SwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
