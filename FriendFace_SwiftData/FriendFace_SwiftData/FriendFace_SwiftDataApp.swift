//
//  FriendFace_SwiftDataApp.swift
//  FriendFace_SwiftData
//
//  Created by Ciaran Murphy on 2/14/24.
//

import SwiftData
import SwiftUI

@main
struct FriendFace_SwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
