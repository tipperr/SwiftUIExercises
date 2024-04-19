//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Ciaran Murphy on 4/18/24.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            VStack {
                Text("Elevation: ")
                    .font(.caption.bold())
                
                Text("\(resort.elevation)m")
                    .font(.title)
            }
            
            VStack{
                Text("Snow:")
                    .font(.caption.bold())
                
                Text("\(resort.snowDepth)cm")
                    .font(.title)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SkiDetailsView(resort: .example)
}
