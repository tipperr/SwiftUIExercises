//
//  Bookworm_TechniquesApp.swift
//  Bookworm-Techniques
//
//  Created by Ciaran Murphy on 2/4/24.
//

import SwiftData
import SwiftUI

@main
struct Bookworm_TechniquesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self)
    }
}
