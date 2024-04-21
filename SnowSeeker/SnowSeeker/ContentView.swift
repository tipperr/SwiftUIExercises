//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ciaran Murphy on 4/17/24.
//

import SwiftUI

extension ContentView {
    enum SortingCriteria: String, CaseIterable, Identifiable {
        case name
        case country
        case runs
        
        var id: String { self.rawValue }
        
        var description: String {
            switch self {
            case .name: return "Name"
            case .country: return "Country"
            case .runs: return "Runs"
            }
        }
        
        var sortingFunction: (Resort, Resort) -> Bool {
            switch self {
            case .name: return { $0.name < $1.name }
            case .country: return { $0.country < $1.country }
            case .runs: return { $0.runs < $1.runs }
            }
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @State private var sortingCriteria: SortingCriteria = .name
    
    var filteredResorts: [Resort]{
        if searchText.isEmpty {
            //resorts
            resorts.sorted(by: sortingCriteria.sortingFunction)
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText)}
                .sorted(by: sortingCriteria.sortingFunction)

        }
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Picker("Sort By", selection: $sortingCriteria) {
                    ForEach(SortingCriteria.allCases, id: \.self) { criteria in
                        Text(criteria.description)
                            .tag(criteria)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            List(filteredResorts) { resort in
                NavigationLink(value: resort){
                    HStack{
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading){
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
        } detail: {
            WelcomeView()
        }
        .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Picker("Sort By", selection: $sortingCriteria) {
                                ForEach(SortingCriteria.allCases, id: \.self) { criteria in
                                    Text(criteria.description).tag(criteria)
                                }
                            }
                        } label: {
                            Label("Sort By", systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
    }
}

#Preview {
    ContentView()
}
