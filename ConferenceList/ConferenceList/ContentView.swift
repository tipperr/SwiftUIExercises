//
//  ContentView.swift
//  ConferenceList
//
//  Created by Ciaran Murphy on 3/7/24.
//

import PhotosUI
import SwiftUI

struct Attendee: Identifiable {
    let id = UUID()
    let image: Image
    var attendeeName: String
}

struct ContentView: View {
    //@State private var conferenceList = []
    @State private var conferenceList = [Attendee]()
    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImage: Image?
    @State private var selectedImages = [Image]()
    @State private var attendeeName = "Attendee Name"
    @State private var showingNameAlert = false
    @State private var showingAttendee = false
    
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            List{
                ForEach(conferenceList) { item in
                    HStack {
                        item.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50) // Adjust size as needed
                        Spacer()
                        Text(item.attendeeName)
                    }
                }
            }
            
            .onChange(of: pickerItem) { _ in
                Task {
                    if let selectedImage = try await pickerItem?.loadTransferable(type: Image.self) {
                        showingNameAlert.toggle()
                        self.selectedImage = selectedImage

                    }
                }
            }
            .alert("Enter attendee's name", isPresented: $showingNameAlert) {
                TextField("Attendee Name", text: $attendeeName)
                
                Button("OK") {

                    let attendee = Attendee(image: selectedImage ?? Image(systemName: "photo"), attendeeName: attendeeName)
                    
                    conferenceList.append(attendee)
                    
                    selectedImage = nil
                    attendeeName = "Attendee Name"
                    
                    showingNameAlert = false
                }
            }
        }
    }
            
            /*
            .onChange(of: pickerItem) { _ in
                Task {
                    if let selectedImage = try await pickerItem?.loadTransferable(type: Image.self) {
                        //let name = await promptForAttendeeName()
                        let imageItem = ImageItem(image: selectedImage, attendeeName: name)
                                                conferenceList.append(imageItem)
                        showingNameAlert.toggle()
                    }
                        .alert("Enter attendee's name", isPresented: $showingNameAlert){
                            TextField("Attendee Name", text: $attendeeName)
                            Button("Ok", action: .submit)
                        }
                }
            }
        }
    }*/
    /*func promptForAttendeeName() async -> String {
        return "Attendee Name"
    }*/
}


#Preview {
    ContentView()
}
