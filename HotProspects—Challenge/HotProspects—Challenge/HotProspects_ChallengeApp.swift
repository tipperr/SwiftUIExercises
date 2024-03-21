//
//  HotProspects_ChallengeApp.swift
//  HotProspects—Challenge
//
//  Created by Ciaran Murphy on 3/21/24.
//

import SwiftUI

@main
struct HotProspects_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
