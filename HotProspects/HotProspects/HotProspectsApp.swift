//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Ciaran Murphy on 3/14/24.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
