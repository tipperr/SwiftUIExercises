//
//  DrawRectangle.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/21/24.
//

import SwiftUI

struct DrawRectangle: View {
    
    var height: CGFloat = 2
    var color: Color = .lightBackground
    var direction: Edge.Set = .vertical
    
    var body: some View {
            Rectangle()
                .frame(height: height)
                .foregroundStyle(color)
                .padding(direction)
    }
}

#Preview {
    DrawRectangle()
}
