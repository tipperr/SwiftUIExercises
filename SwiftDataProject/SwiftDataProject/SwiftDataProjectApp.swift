//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Ciaran Murphy on 2/7/24.
//
import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
