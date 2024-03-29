//
//  Card.swift
//  FlashZilla—Challenge
//
//  Created by Ciaran Murphy on 3/29/24.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the thirteenth Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
