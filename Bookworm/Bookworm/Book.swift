//
//  Book.swift
//  Bookworm
//
//  Created by Ciaran Murphy on 2/5/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    //var date = Date.now
    var dateAdded = Date()
    
    init(title: String, author: String, genre: String, review: String, rating: Int, dateAdded: Date = Date() /*date: Foundation.Date = Date.now*/) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.dateAdded = dateAdded
    }
    
}
