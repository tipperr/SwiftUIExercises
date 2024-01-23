//
//  ListItems.swift
//  Moonshot
//
//  Created by Ciaran Murphy on 1/22/24.
//

import SwiftUI

struct ListItems: View {
    let mission: Mission

        var body: some View {
            //Text("Hello")
            /*VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()

                VStack {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text(mission.formattedLaunchDate /*launchDate ?? "N/A"*/)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.lightBackground)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            )*/
            
            VStack(alignment: .leading) {
                
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(mission.formattedLaunchDate /*launchDate ?? "N/A"*/)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            //.background(Color.red)
            .background(.lightBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            )
        }
    }
