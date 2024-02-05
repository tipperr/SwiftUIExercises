//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ciaran Murphy on 2/5/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
