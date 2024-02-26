//
//  Location.swift
//  BucketList
//
//  Created by Ciaran Murphy on 2/26/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    let name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
