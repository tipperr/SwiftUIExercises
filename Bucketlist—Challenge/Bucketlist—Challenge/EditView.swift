//
//  EditView.swift
//  Bucketlist—Challenge
//
//  Created by Ciaran Murphy on 2/28/24.
//

import SwiftUI

struct EditView: View {
    /*enum LoadingState {
        case loading, loaded, failed
    }*/
    
    @Environment(\.dismiss) var dismiss
    /*var location: Location
    
    @State private var name: String
    @State private var description: String*/
    
    @State private var viewModel: ViewModel
    
    var onSave: (Location) -> Void
    
    //@State private var loadingState = LoadingState.loading
    //@State private var pages = [Page]()
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                 
                Section("Nearby..."){
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                        
                    case .loaded:
                        ForEach(viewModel.pages, id:\.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            
                            + Text(": ") +
                            
                            Text(page.description)
                                .italic()
                        }
                        
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar{
                Button("Save"){
                    //var newLocation = location
                    //newLocation.id = UUID()
                    //newLocation.name = name
                    //newLocation.description = description
                    let newLocation = viewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task{
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void){
        //self.location = location
        self.onSave = onSave
        _viewModel = State(initialValue: ViewModel(location: location))
        
        //_name = State(initialValue: location.name)
        //_description = State(initialValue: location.description)
    }
    
    /*func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted() /*{ $0.title < $1.title }*/
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }*/
}

#Preview {
    EditView(location: .example) { _ in }
}
