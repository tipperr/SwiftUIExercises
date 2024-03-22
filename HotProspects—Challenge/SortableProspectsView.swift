//
//  SortableProspectsView.swift
//  HotProspects—Challenge
//
//  Created by Ciaran Murphy on 3/22/24.
//

import SwiftUI

struct SortableProspectsView: View {
    
    let filter: ProspectsView.FilterType
    @State private var sortOrder = SortDescriptor(\Prospect.name)
    
    var body: some View {
        NavigationStack {
            ProspectsView(filter: filter, sort: sortOrder)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort") {
                            Picker("Sort Order", selection: $sortOrder) {
                                Text("Date Added")
                                    .tag(SortDescriptor(\Prospect.dateAdded))

                                Text("Name")
                                    .tag(SortDescriptor(\Prospect.name))
                            }
                        }
                    }
                }
        } 
    }
}

#Preview {
    SortableProspectsView(filter: .none)
}
