//
//  ActivityDetail.swift
//  ActivityTracker
//
//  Created by Ciaran Murphy on 1/29/24.
//

import SwiftUI

struct ActivityDetail: View {
    
    @Binding var activity: Activity
    
    var body: some View {
        VStack {
            Text("Activity: \(activity.name)")
                .font(.title)
                .padding()
            Spacer()
            Text("Performed \(activity.count) \(activity.count == 1 ? "time" : "times")")
            Spacer()
            
            if !activity.dates.isEmpty {
                List {
                                Text("\(activity.dates.first.map { dateFormatter.string(from: $0) } ?? "N/A")")
                    ForEach(activity.dates.dropFirst().reversed(), id: \.self) { date in
                                        Text("\(date, formatter: dateFormatter)")
                                    }
                            }
                        }
            
            Button("I did it again!"){
                activity.count += 1
                let currentDate = Date()
                activity.dates.append(currentDate)
                activity.dates.reverse()
                print("Activity dates: \(activity.dates)")
            }
            
            Spacer()
                .navigationTitle("Activity Details")
            
        }
    }
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .long
            return formatter
        }()
}
/*
#Preview {
    ActivityDetail()
}
*/

/*struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(activity: Activity(name: "Sample Activity", count: 1))
    }
}*/
