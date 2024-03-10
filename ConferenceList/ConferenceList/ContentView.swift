//
//  ContentView.swift
//  ConferenceList
//
//  Created by Ciaran Murphy on 3/7/24.
//

import PhotosUI
import SwiftUI

struct Attendee: Identifiable, Codable {
    let id = UUID()
    //let image: Image
    let imageData: Data
    var attendeeName: String
}

class Attendees: ObservableObject {
    @Published var attendees = [Attendee]() {
        didSet {
            saveAttendees() // Save attendees whenever the list changes
        }
    }
    
    init() {
        loadAttendees() // Load attendees when the app starts
    }
    
    private func saveAttendees() {
        do {
            let data = try JSONEncoder().encode(attendees)
            UserDefaults.standard.set(data, forKey: "attendees")
        } catch {
            print("Error saving attendees: \(error)")
        }
    }
    
    private func loadAttendees() {
        if let data = UserDefaults.standard.data(forKey: "attendees") {
            do {
                attendees = try JSONDecoder().decode([Attendee].self, from: data)
            } catch {
                print("Error loading attendees: \(error)")
            }
        }
    }
}

struct ContentView: View {
    //@State private var conferenceList = []
    @StateObject private var attendees = Attendees()
    @State private var conferenceList = [Attendee]()
    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImage: Image?
    @State private var selectedImageData: Data?
    //@State private var selectedImages = [Image]()
    @State private var attendeeName = "Attendee Name"
    @State private var showingNameAlert = false
    @State private var showingAttendee = false
    
    
    var body: some View {
        NavigationView{
            VStack {
                PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
                List{
                    //ForEach(conferenceList) { attendee in
                    ForEach(attendees.attendees) { attendee in
                        NavigationLink(destination: AttendeeView(attendee: attendee)){
                            HStack {
                                Image(uiImage: UIImage(data: attendee.imageData) ?? UIImage(systemName: "person.circle.fill")!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Spacer()
                                Text(attendee.attendeeName)
                            }
                        }
                    }
                }
                
                .onChange(of: pickerItem) { _ in
                    Task {
                        if let imageData = try await pickerItem?.loadTransferable(type: Data.self) {
                            selectedImageData = imageData
                            showingNameAlert.toggle()
                        }
                    }
                }
                .alert("Enter attendee's name", isPresented: $showingNameAlert) {
                    TextField("Attendee Name", text: $attendeeName)
                    
                    Button("OK") {
                        if let imageData = selectedImageData {
                            let attendee = Attendee(imageData: imageData, attendeeName: attendeeName)
                            //conferenceList.append(attendee)
                            attendees.attendees.append(attendee)
                        }
                        selectedImageData = nil
                        attendeeName = "Attendee Name"
                        showingNameAlert = false
                    }
                }
            }
        }
    }

}


#Preview {
    ContentView()
}
