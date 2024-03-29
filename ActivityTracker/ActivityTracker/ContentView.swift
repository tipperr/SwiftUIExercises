//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Ciaran Murphy on 1/27/24.
//

import SwiftUI

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var count: Int = 0
    var dates: [Date] = []
}

//@Observable
class Activities: ObservableObject {
    @Published var myActivities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(myActivities){
                UserDefaults.standard.set(encoded, forKey: "My Activities")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "My Activities"){
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems){
                myActivities = decodedItems
                return
            }
        }
        myActivities = []
    }
}

struct ContentView: View {
    
    @ObservedObject private var activities = Activities()
    @State private var showingAddActivity = false
    @State private var selectedActivity: Activity?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($activities.myActivities) { $activity in
                        NavigationLink(destination: ActivityDetail(activity: $activity)) {
                            Text("\(activity.name): Performed")
                            Text("\(activity.count) \(activity.count == 1 ? "time" : "times")")
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("Activity Tracker")
            .toolbar {
                Button("Add Activity") {
                    showingAddActivity = true
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivity(activities: activities)
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        activities.myActivities.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
