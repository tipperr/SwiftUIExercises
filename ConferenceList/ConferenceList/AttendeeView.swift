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
            attendee.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
            Text(attendee.attendeeName)
            
        }
    }
}

struct AttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        let attendee = Attendee(image: Image(systemName: "person.circle.fill"), attendeeName: "John Doe")
        return AttendeeView(attendee: attendee)
    }
}

/*#Preview {
    AttendeeView()
}*/
