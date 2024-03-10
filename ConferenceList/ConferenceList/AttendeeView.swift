//
//  AttendeeView.swift
//  ConferenceList
//
//  Created by Ciaran Murphy on 3/8/24.
//

import PhotosUI
import SwiftUI

struct AttendeeView: View {
    let attendee: Attendee
    
    var body: some View {
        VStack{
            Image(uiImage: UIImage(data: attendee.imageData) ?? UIImage(systemName: "person.circle.fill")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                        Text(attendee.attendeeName)
                .font(.title)            
        }
    }
}

struct AttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        let imageData = Data() // Placeholder image data
        let attendee = Attendee(imageData: imageData, attendeeName: "John Doe")
        return AttendeeView(attendee: attendee)
    }
}

/*#Preview {
    AttendeeView()
}*/
