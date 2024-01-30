//
//  AddActivity.swift
//  ActivityTracker
//
//  Created by Ciaran Murphy on 1/27/24.
//

import SwiftUI



struct AddActivity: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Name"
    
    //@State private var times = 1
    
    @State private var showAlert = false
    
    var activities: Activities
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
            }
            .navigationTitle("New Activity")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        if !name.isEmpty {
                            let hasDuplicate = activities.myActivities.contains { $0.name.lowercased() == name.lowercased() }
                            if !hasDuplicate {
                                let currentDate = Date()
                                let activity = Activity(name: name, count: 1, dates: [currentDate])
                                activities.myActivities.append(activity)
                                print("Activity dates: \(activity.dates)")

                                dismiss()
                            } else {
                                showAlert = true
                            }
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Duplicate Activity"), message: Text("This activity already exists."), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }
}

#Preview {
    AddActivity(activities: Activities())
}
