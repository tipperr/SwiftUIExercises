//
//  EditingView.swift
//  HotProspects—Challenge
//
//  Created by Ciaran Murphy on 3/21/24.
//

import SwiftData
import SwiftUI

struct EditingView: View {
    @Bindable var prospect: Prospect
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $prospect.name)
                TextField("Email Address", text: $prospect.emailAddress)
                Toggle("Contacted", isOn: $prospect.isContacted)
            }
            
            .navigationTitle("Edit Prospect")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let example = Prospect(name: "Example User", emailAddress: "example@user.com", isContacted: false)

        return EditingView(prospect: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
